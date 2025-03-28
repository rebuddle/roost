// movement
move_sp = 2;
dash_dur = 4;
dash_cd = 0;
move_state = 0;
horz = 0;
vert = 0;

// animation
sprite = [spr_player_right
	, spr_player_up
	, spr_player_left
	, spr_player_down];
	
// direction macros
#macro RIGHT 0
#macro UP 1
#macro LEFT 2
#macro DOWN 3

// player states
enum player_state {
	idle,
	move,
	dash
}
// states of state machine
enum state {
	start,
	step,
	stop
}

// starting state
_part_state = state.start;
_current_state = player_state.idle;


// player movement function state
player_movement = function(){
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