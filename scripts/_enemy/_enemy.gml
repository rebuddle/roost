// _enemy.gml
function ENEMY() 
	constructor {
		/* variables */
		object= obj_enemy;
		move_speed= 1;
		max_hp = 6;
		hp = max_hp;
		sprite_index = spr_enemy_zombie_front;
		image_index = 0;
		frame = 0;
		//dir_index = 0;
		
		/* init */
		_enemy_state_init();
		
		/* methods */
		// draw sprite
		draw= function() {
			// draw sprite and index
			draw_sprite(sprite_index, image_index, object.x, object.y);
		}
		
		// state machine
		update= fsm.step;
		
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
				if (place_meeting(x+_xsp, y, obj_wall)){
					_xsp = 0;
				}
				if (place_meeting(x, y+_ysp, obj_wall)){
					_ysp = 0;
				}
			}
			// move
			object.x+=_xsp;
			object.y+=_ysp;
		}
}

function _enemy_state_init(){
	// IDLE
	idle_state = new state(
		function() { // start
			// init vars
			frame = 0;
		},
		function() { // step
			// increase frame
			frame++;
			
			// animate
			if (frame mod 12 == 0) {
				image_index++;
			}
			
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
		},
	    function() {
			// increment
			frame++;
			
			// animate
			if (frame mod 12 == 0) {
				image_index++;
			}
			
			// trigger attack
			
			// trigger idle
			if (frame > 120) {
				fsm.change_state("attack");	
			}
			
			// movement
			//dir_index = point_direction(0, 0, horz, vert) div 90;
	        enemy_movement();
		}
	);
	
	// ATTACK
	attack_state = new state(
	    function() { 
			// init vars
			frame = 0;
		},
	    function() {
			// trigger attack
			
			fsm.change_state("idle");
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


// function to build out enemies
function _add_enemy(_name, _max_hp, _move_speed, _damage, _attack_speed, _defence, _obj_enemy, _spr_enemy) {
    return {
        name: _name,
		max_hp: _max_hp,
		move_speed: _move_speed,
		damage: _damage,
		attack_speed: _attack_speed,
		defence: _defence,
		enemy_object: _obj_enemy,
		enemy_sprite: _spr_enemy,
		
		spawn: function(_x, _y, _depth) {
			var enemy = instance_create_depth(_x, _y, _depth+1, self.enemy_object);
			enemy.max_hp = self.max_hp;
			enemy.hp = self.max_hp;
			enemy.move_speed = self.move_speed;
			enemy.sprite_index = self.enemy_sprite;
		}
    };
}

// build out armor
global.enemy_list = {
		"green_box": _add_enemy("Green Box", 4, 4, 1, 1, 0, obj_enemy, spr_enemy_zombie_front),
		"pink_box": _add_enemy("Pink Box", 10, 4, 1, 1, 0, obj_enemy, spr_enemy_rogue_front)
};