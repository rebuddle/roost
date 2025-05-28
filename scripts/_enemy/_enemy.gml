// _enemy.gml
function ENEMY() 
	constructor {
		/* variables */
		object= obj_enemy;
		move_speed= 1;
		max_hp = 8;
		hp = max_hp;
		sprite_index = spr_enemy_zombie_front;
		image_index = 0;
		frame = 0;
		bullet_speed = 2;
		bullet_timer = 90;
		
		/* init */
		_enemy_state_init();
		
		/* methods */
		// controller
		update= function() {
			// vars
			frame++;
			
			// actions
			fsm.step();
			
			// clean up
			take_damage();
		}
		
		// animation
		draw= function() {
			if (frame mod 12 == 0) {
				image_index++;
			}
			// draw sprite and index
			draw_sprite(sprite_index, image_index, object.x, object.y);
			draw_hp();
		}
		
		/* helper functions */
		// movement
		enemy_movement = function () {
			// get input
			var _mdir = point_direction(object.x, object.y, obj_player.x, obj_player.y);
			
			// normalize distance
			var _dist = point_distance(object.x, object.y, obj_player.x, obj_player.y);
			_dist = clamp(_dist, 0, 1);
	
			// translate to x and y
			var _spd = move_speed * _dist;
			var _xsp = lengthdir_x(_spd, _mdir);
			var _ysp = lengthdir_y(_spd, _mdir);
			
			// collision - !! Can be better !!
			with (object){
				if (place_meeting(x+_xsp, y, obj_wall) || place_meeting(x+_xsp, y, obj_player)){
					_xsp = 0;
				}
				if (place_meeting(x, y+_ysp, obj_wall) || place_meeting(x, y+_ysp, obj_player)){
					_ysp = 0;
				}
			}
			
			// move
			object.x+=_xsp;
			object.y+=_ysp;
		}
		
		// attack
		enemy_attack_explosion = function() {
			for (i=0;i<360;i+=30){
				var blast = instance_create_depth(object.x, object.y, object.depth, obj_enemy_proj);
				with (blast) {
					// create
					alarm[0]= other.bullet_timer;
					bullet_speed = other.bullet_speed;
					theta = other.i;
					curve_coeff = other.curve_coeff;
					frame = 0;
					// update
					proj_path = proj_path_spiral; 
				}
			}
		}
		
		draw_hp = function() {
			// In the Draw Event
			// Calculate the healthbar percentage
			var health_percentage = (hp / max_hp) * 100;
			// Draw the healthbar
			draw_healthbar(object.x - 2.5, object.y + 5, object.x + 2, object.y + 5.5//x - 25, y - 20, x + 25, y - 10
							,health_percentage, c_black, c_red, c_green
							, 0, true, false);
		}
		
		take_damage = function(){
			// hit by player
			if instance_exists(obj_projectile){
				var hit = point_distance(object.x, object.y, obj_projectile.x, obj_projectile.y); // <46
				if (hit <= 15) {
					show_debug_message("<Enemy> - Hit by player!" + string(hp));
					instance_destroy(instance_nearest(object.x, object.y, obj_projectile));
					instance_create_depth(object.x, object.y, object.depth, obj_enemyhit);
					hp--;
				}
			}
			// enemy destroyed
			if (hp <= 0){
				instance_destroy(obj_enemy);
				return;
			}
		}
}


/* projectile helper functions */
function proj_path_spiral() {
	frame++;
	
	var delta_x = lengthdir_x(bullet_speed, theta + frame*curve_coeff);
	var delta_y = lengthdir_y(bullet_speed, theta + frame*curve_coeff);

	x+=delta_x;
	y+=delta_y;	
}

/* enemy state machine */
function _enemy_state_init(){
	// IDLE
	idle_state = new state(
		function() { // start
			// init vars
			frame = 0;
			//show_debug_message("<Enemy> - Entering Idle State..."); 
		},
		function() { // step
			// trigger movement
			if (frame > 60) {
			    fsm.change_state("move");
			}
		}
	);

	// MOVE
	move_state = new state(
	    function() { 
			// init vars
			frame = 0;
			//show_debug_message("<Enemy> - Entering Move State..."); 
		},
	    function() {
			// trigger attack
			if (frame > 120) {
				fsm.change_state("attack");	
			}
			
			// movement
	        enemy_movement();
		}
	);
	
	// ATTACK
	attack_state = new state(
	    function() { 
			// init vars
			frame = 0;
			curve_coeff = random(3);
			//show_debug_message("<Enemy> - Entering Attack State...");
		},
	    function() {
			// trigger attack
			if (frame mod 15 == 0){
				enemy_attack_explosion();
			}
			
			// change state
			if (frame > 60){
				fsm.change_state("idle");
			}
	    }
	);

	// init FSM
	fsm = FSM(undefined);

	// add states
	fsm.add_state("idle", idle_state);
	fsm.add_state("move", move_state);
	fsm.add_state("attack", attack_state);

	fsm.change_state("idle");	
	
}