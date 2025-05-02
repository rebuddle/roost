// hi-score: 412

// player manager: levels, stats, and gear
player_manager = {
	max_hp: 12,
	hp: 12,
	
	// base stats
	attack: 5,
	dexterity: 5,
	defence: 5,
	vitality: 5,
	wisdom: 5,
	move_speed: 5,
	
	// cooldowns
	dash_cooldown: 0,
	
	// gear
	lhand: noone,
	rhand: noone,
	helm: noone,
	armor: noone,
	boots: noone
}

// equip gear
player_manager.lhand = global.weapon_list[$ "sword"];
player_manager.rhand = global.weapon_list[$ "bow"];

// player states: idle, move, dash
// IDLE
idle_state = new state(
    function() { // start
        sprite = [spr_player_box, spr_player_box, spr_player_box, spr_player_box];
    },
    function() { // step
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
		lattkey = mouse_check_button(mb_left);
		rattkey = mouse_check_button(mb_right);
		
		// trigger attack
		if (lattkey) {
			_script_attack(x,y,depth+1);
		}
		if (rattkey) {
			_script_attack(x,y,depth+1);
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
		player_manager.move_speed = 8; 
	},
    function() {
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * player_manager.move_speed;
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * player_manager.move_speed;
		dkey = keyboard_check(vk_space);
		lattkey = mouse_check_button(mb_left);
		rattkey = mouse_check_button(mb_right);
		
		// trigger attack
		if (lattkey) {
			_script_attack(x,y,depth+1);
		}
		if (rattkey) {
			_script_attack(x,y,depth+1);
		}
		
		// trigger dash state
		if (!player_manager.dash_cooldown && dkey) && (abs(horz) > 0 || abs(vert) > 0) {
			fsm.change_state("dash");
			return;
		}

		// move back to idle state
        if (abs(horz) == 0 && abs(vert) == 0) {
            fsm.change_state("idle");
			return;
        }

        _script_movement(horz, vert, player_manager.move_speed);
    }
);

// DASH
dash_state = new state(
	function() {
		player_manager.dash_cooldown = 30;
		dash_dur = player_manager.move_speed * 1.5;
		player_manager.move_speed = 16;
	},
	function() {
		// dash
		_script_movement(horz, vert, player_manager.move_speed);
		
		// trail effect
		with (instance_create_depth(x, y, depth+1, obj_player_dash_trail)){
			sprite_index = other.sprite_index;
			//image_blend = c_silver;
			image_blend = c_fuchsia;
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
