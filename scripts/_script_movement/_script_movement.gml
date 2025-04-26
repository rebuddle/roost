function _script_movement(horz, vert, move_speed){
	var _mdir = point_direction(0, 0, horz, vert);
	// normalize distance
	var _dist = point_distance(0, 0, horz, vert);
	_dist = clamp(_dist, 0, 1);
	// translate to x and y
	var _spd = move_speed * _dist;
	var _xsp = lengthdir_x(_spd, _mdir);
	var _ysp = lengthdir_y(_spd, _mdir);
	
	// animation
	/*
	if abs(horz) > 0 || abs(vert) > 0 {
		sprite_index = sprite[round(_mdir/90)%4];
	}
	*/

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