// variables
dash_cd = 0;

// [[ Player States ]]
// IDLE
idle_state = new state(
    function() { // start
        sprite = [spr_player_box, spr_player_box, spr_player_box, spr_player_box];
    },
    function() { // step
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
        if (abs(horz) > 0 || abs(vert) > 0) {
            fsm.change_state("move");
        }
    }
);

// MOVE
move_state = new state(
    function() { 
		move_sp = 8; 
	},
    function() {
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * move_sp;
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * move_sp;
		dkey = keyboard_check(vk_space);
		akey = mouse_check_button_pressed(mb_left);
		
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

        _player_movement();
    }
);

// DASH
dash_state = new state(
	function() {
		dash_cd = 30;
		dash_dur = 12;
		move_sp = 16;
	},
	function() {
		// dash
		_player_movement();
		
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
