// _player.gml
function PLAYER()
	constructor {
		/* variables */
		object= obj_player;
	    move_speed= 2;
		horz =0;
		vert =0;
		dash_dur = 0;
		dash_cooldown= 0;
		max_hp = 6;
		hp = max_hp;
		weapon = global.weapon_list[$ "sword"];
		sprite_index = spr_player_priest_front;
		
		/* initialization */
		_player_state_init();
		
		/* methods */
		// draw sprite
		draw= function() {
			draw_sprite(sprite_index, 0, object.x, object.y);
	    }
		
		// state machine
		update= fsm.step;
		
		// attack
		player_attack = function () {
			weapon.attack();
		}
	
		// movement
		player_movement = function () {
			// get input
			var _mdir = point_direction(0, 0, horz, vert);
			// normalize distance
			var _dist = point_distance(0, 0, horz, vert);
			_dist = clamp(_dist, 0, 1);
	
			// translate to x and y
			var _spd = move_speed * _dist;
			var _xsp = lengthdir_x(_spd, _mdir);
			var _ysp = lengthdir_y(_spd, _mdir);
			
			// collision - !! Can be better !!
			with (object){
				if (place_meeting(x+_xsp, y, obj_wall)){
					_xsp = 0;
				}
				if (place_meeting(x, y+_ysp, obj_wall)){
					_ysp = 0;
				}
				if (place_meeting(x, y, obj_enemy)){
					show_debug_message("OUCH!");	
				}
			}
			
			
			// move
			object.x+=_xsp;
			object.y+=_ysp;
		}
		
		// cooldowns
		cooldowns = function () {
			// update cooldown
			if dash_cooldown > 0 {
				dash_cooldown--;
			}
			if (weapon) {
				weapon.cooldowns();	
			}
		}
}

function _player_state_init(){
	// IDLE
	idle_state = new state(
		    function() { // start
		        // insert sprite
		    },
		    function() { // step
		        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
		        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
				att_key = mouse_check_button(mb_left);
		
				// trigger attack
				if (att_key) {
					player_attack();
				}
		
				// trigger movement
		        if (abs(horz) > 0 || abs(vert) > 0) {
		            fsm.change_state("move");
		        }
		    }
		);

	// MOVE
	move_state = new state(
	    function() { 
			move_speed = 2; 
		},
	    function() {
	        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * move_speed;
	        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * move_speed;
			dash_key = keyboard_check(vk_space);
			att_key = mouse_check_button(mb_left);
		
			// trigger attack
			if (att_key) {
				player_attack();
				
			}
		
			// trigger dash state
			if (!dash_cooldown && dash_key) && (abs(horz) > 0 || abs(vert) > 0) {
				fsm.change_state("dash");
				return;
			}

			// move back to idle state
	        if (abs(horz) == 0 && abs(vert) == 0) {
	            fsm.change_state("idle");
				return;
	        }

	        player_movement();
	    }
	);

	// DASH
	dash_state = new state(
		function() {
			dash_cooldown = 30;
			move_speed = 4;
			dash_dur = move_speed * 1.5;
		},
		
		function() {
			// dash
			player_movement();
		
			// trail effect
			with (instance_create_depth(object.x, object.y, object.depth+1, obj_player_dash_trail)){
				sprite_index = other.sprite_index;
				image_blend = c_silver;
				//image_blend = c_fuchsia;
				image_alpha = 0.7;
			}
			
			// hold dash state until duration is out
			dash_dur = max(dash_dur-1, 0);
			if dash_dur == 0 {
				fsm.change_state("idle");
			}	
		}
	);
	// init FSM
	fsm = FSM(undefined);

	// add states
	fsm.add_state("idle", idle_state);
	fsm.add_state("move", move_state);
	fsm.add_state("dash", dash_state);

	fsm.change_state("idle");	
	
}