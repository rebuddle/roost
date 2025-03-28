// get player input
var _move = [keyboard_check(ord("D"))
		, keyboard_check(ord("W"))
		, keyboard_check(ord("A"))
		, keyboard_check(ord("S"))];
var _dkey = keyboard_check(vk_space);

// cooldown timer
dash_cd = max(dash_cd -1, 0);

// state machine
switch(_current_state) 
{
	// idle
	case player_state.idle:
	{
		// start state
		if _part_state = state.start {
			_part_state = state.step;
		}
		
		// step state
		if _part_state = state.step {
			// player input
			horz = (_move[RIGHT] - _move[LEFT])*move_sp;
			vert = (_move[DOWN] - _move[UP])*move_sp;
			
			// trigger movement state
			if (abs(horz) > 0 || abs(vert) > 0) {
				_part_state = state.stop;
				_current_state = player_state.move;
			}
		}
		
		// stop state
		if _part_state = state.stop {
			_part_state = state.start;
		}
		
		break;
	}
	
	// moving
	case player_state.move:
	{
		// start state
		if _part_state = state.start {
			move_sp = 4;
			_part_state = state.step;
		}
		
		// step state
		if _part_state = state.step {
			// get player input
			horz = (_move[RIGHT] - _move[LEFT])*move_sp;
			vert = (_move[DOWN] - _move[UP])*move_sp;
			
			// trigger dash state
			if (dash_cd == 0 && _dkey) && (abs(horz) > 0 || abs(vert) > 0) {
				_part_state = state.stop;
				_current_state = player_state.dash;
			}
			
			// invoke player movement
			player_movement();
		}
		
		// stop state
		if _part_state = state.stop {
			_part_state = state.start;
		}
		
		break;
	}
	
	// moving
	case player_state.dash:
	{
		// start state
		if _part_state = state.start {
			dash_cd = 60;
			dash_dur = 8;
			move_sp = 8;
			_part_state = state.step;
		}
		
		// step state
		if _part_state = state.step {
			// dash
			player_movement();
			
			// hold dash state until duration is out
			dash_dur = max(dash_dur-1, 0);
			if dash_dur == 0 {
				_part_state = state.stop;
			}
			
		}
		
		// stop state
		if _part_state = state.stop {
			_part_state = state.start;
			_current_state = player_state.idle;
		}
		
		break;
	}
}


/*
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
*/