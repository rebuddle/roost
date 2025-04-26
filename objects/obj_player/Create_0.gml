// variables
dash_cd = 0;

// player stats
player_manager = {
	// resource stats
	max_hp: 12,
	hp: 12,
	max_mana: 100,
	mana: 100,
	
	// base stats
	strength: 10,
	agility: 10,
	vitality: 10,
	wisdom: 10,
	move_speed: 8,
	
	// gear
	weapon: "iron_dagger",
	helmet: "",
	armor: "",
	ring: ""
}

// change weapon for debug
//player_manager.weapon = "iron_sword";

// [[ Player States ]]
// IDLE
idle_state = new state(
    function() { // start
        sprite = [spr_player_box, spr_player_box, spr_player_box, spr_player_box];
    },
    function() { // step
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
		akey = mouse_check_button_pressed(mb_left);
		
		// trigger attack
		if (akey) {
			global.weapon_list[$ player_manager.weapon].attack(x, y, depth);
		}
		
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
		akey = mouse_check_button_pressed(mb_left);
		
		// trigger attack
		if (akey) {
			global.weapon_list[$ player_manager.weapon].attack(x, y, depth);
		}
		
		// trigger dash state
		if (!dash_cd && dkey) && (abs(horz) > 0 || abs(vert) > 0) {
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
		dash_cd = 30;
		dash_dur = 12;
		player_manager.move_speed = 16;
	},
	function() {
		// dash
		_script_movement(horz, vert, player_manager.move_speed);
		
		// trail effect
		with (instance_create_depth(x, y, depth+1, obj_trail)){
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
