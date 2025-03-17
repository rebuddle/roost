function player_movement(x_sp, y_sp, move_sp, move_dir, movement){
	// movment speed
	var _horz = (movement[RIGHT] - movement[LEFT])*move_sp;
	var _vert = (movement[DOWN] - movement[UP])*move_sp;
	move_dir = point_direction(0, 0, _horz, _vert);
	
	// normalize diagonal movement
	var _spd = 0;
	var _dist = point_distance(0, 0, _horz, _vert);
	_dist = clamp(_dist, 0, 1);
	_spd = move_sp * _dist;
	
	x_sp = lengthdir_x(_spd, move_dir);
	y_sp = lengthdir_y(_spd, move_dir);

	// collision
	if (place_meeting(x+x_sp, y, obj_wall)){
		x_sp = 0;
	}
	
	if (place_meeting(x, y+y_sp, obj_wall)){
		y_sp = 0;
	}

	// move
	x+=x_sp;
	y+=y_sp;
}