// movement
move_sp = 3;
dash_dur = 4;
dash_sp = 4;
dash_cd = 0;
horz = 0;
vert = 0;
dkey = 0;

//	###	[FSM] ####
// player states
enum player_state {
	IDLE,
	MOVE,
	DASH,
	ATTACK
}

// state phases
enum state_step {
	BEGIN,
	STEP,
	END
}
// kick off counter
pstate = player_state.IDLE; // player state
sstep = state_step.BEGIN; // state step

/* INCOMPLETE UPGRADE */

// #########################
// [[ Player States ]] #FSM#
// #########################
// IDLE
idle_state = new state();

idle_state.start = function(){
	sprite = [spr_player_box
		, spr_player_box
		, spr_player_box
		, spr_player_box];
	_current_state = idle_state.step;
}

idle_state.step = function() {
	// get player input
	horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
	vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
	
	// trigger movement state
	if (abs(horz) > 0 || abs(vert) > 0) {
		idle_state.stop();
		_current_state = move_state.start;
	}
}

idle_state.stop = function() {
}

// MOVE
move_state = new state();

move_state.start = function() {
	move_sp = 4;
	_current_state = move_state.step;
}

move_state.step = function() {
	// get player input
	horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")))*move_sp;
	vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")))*move_sp;
	dkey = keyboard_check(vk_space);
	akey = mouse_check_button_pressed(mb_left);
	
	// trigger dash state
	if (!dash_cd && dkey) && (abs(horz) > 0 || abs(vert) > 0) {
		move_state.stop();
		_current_state = dash_state.start;
		return;
	}
	
	// trigger idle state
	if (abs(horz) == 0 && abs(vert) == 0) {
		move_state.stop();
		_current_state = idle_state.start;
	}
	
	// invoke player movement
	_player_movement();	
		
}

// DASH
dash_state = new state();

dash_state.start = function() {
	dash_cd = 40;
	dash_dur = 12;
	move_sp = 8;
	_current_state = dash_state.step;
}

dash_state.step = function() {
	// dash
	_player_movement();
			
	// hold dash state until duration is out
	dash_dur = max(dash_dur-1, 0);
	if dash_dur == 0 {
		dash_state.stop();
		_current_state = idle_state.start;
		return;
	}	
}

// init state
_current_state = idle_state.start;