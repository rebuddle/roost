/*
// macros
#macro RIGHT 0
#macro UP 1
#macro LEFT 2
#macro DOWN 3

// player movement function state
function player_movement(move_sp, sprite, _horz, _vert){
	var _mdir = point_direction(0, 0, _horz, _vert);
	// normalize distance
	var _dist = point_distance(0, 0, _horz, _vert);
	_dist = clamp(_dist, 0, 1);
	// translate to x and y
	var _spd = move_sp * _dist;
	var _xsp = lengthdir_x(_spd, _mdir);
	var _ysp = lengthdir_y(_spd, _mdir);
	
	// animation
	if !(_horz == 0 && _vert == 0) {
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

// player dash
function player_dash(move_sp, sprite, _horz, _vert){
	var _mdir = point_direction(0, 0, _horz, _vert);
	// normalize distance
	var _dist = point_distance(0, 0, _horz, _vert);
	_dist = clamp(_dist, 0, 1);
	// translate to x and y
	var _spd = move_sp * _dist;
	var _xsp = lengthdir_x(_spd, _mdir);
	var _ysp = lengthdir_y(_spd, _mdir);
	
	// animation
	if !(_horz == 0 && _vert == 0) {
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
*/