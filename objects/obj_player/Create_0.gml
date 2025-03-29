// movement
move_sp = 3;
dash_dur = 4;
dash_sp = 4;
dash_cd = 0;
horz = 0;
vert = 0;

sprite = [spr_player_right
		, spr_player_up
		, spr_player_left
		, spr_player_down];
		

// player movement function state
player_movement = function() {
	var _mdir = point_direction(0, 0, horz, vert);
	// normalize distance
	var _dist = point_distance(0, 0, horz, vert);
	_dist = clamp(_dist, 0, 1);
	// translate to x and y
	var _spd = move_sp * _dist;
	var _xsp = lengthdir_x(_spd, _mdir);
	var _ysp = lengthdir_y(_spd, _mdir);
	
	// animation
	if !(horz == 0 && vert == 0) {
		var _face = round(_mdir/90)%4;
		sprite_index = sprite[_face];
	}

	// collision
	if (place_meeting(x+_xsp, y, obj_wall)){
		_xsp = 0;
	}
	if (place_meeting(x, y+_ysp, obj_wall)){
		_ysp = 0;
	}

	// move
	x+=_xsp;
	y+=_ysp;
}


// #########################
// [[ Player States ]] #FSM#
// #########################
// IDLE
idle_state = new state();

idle_state.start = function(){
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
	show_debug_message("move step...");
	// get player input
	horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")))*move_sp;
	vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")))*move_sp;
	_dkey = keyboard_check(vk_space);
			
	// trigger dash state
	if (!dash_cd && _dkey) && ((horz) || (vert)) {
		move_state.stop();
		_current_state = dash_state.start;
		return;
	}
			
	// invoke player movement
	player_movement();
}

// DASH
dash_state = new state();

dash_state.start = function() {
	dash_cd = 40;
	dash_dur = 8;
	move_sp = 12;
	_current_state = dash_state.step;
}

dash_state.step = function() {
	// dash
	player_movement();
			
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