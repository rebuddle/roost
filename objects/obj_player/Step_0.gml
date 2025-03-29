// invoke player movement
var _move = [keyboard_check(ord("D"))
		, keyboard_check(ord("W"))
		, keyboard_check(ord("A"))
		, keyboard_check(ord("S"))];
// calculate movement in x & y
var _horz = (_move[RIGHT] - _move[LEFT])*move_sp;
var _vert = (_move[DOWN] - _move[UP])*move_sp;

// enable dash state
var _dkey = keyboard_check(vk_space);
// reduce dash duration by seconds each step
dash_cd = max(dash_cd - 1, 0);

// invoke movement/dash
if dash_cd == 0 && _dkey {
	// invoke dashing state resetting parameters
	horz = _horz;
	vert = _vert;
	dash_cd = 30;
	move_state = 1;
	player_movement(move_sp*dash_sp, sprite, horz, vert);
} else if move_state = 1 {
	// currently dashign state
	player_movement(move_sp*dash_sp, sprite, horz, vert);
	dash_dur = max(dash_dur -1, 0)
	
	// dash is finished
	if dash_dur == 0 {
		move_state = 0;
		dash_dur = 4;
	}
} else {
	// movement state
	player_movement(move_sp, sprite, _horz, _vert);
}