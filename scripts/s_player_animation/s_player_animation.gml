function player_animation(sprite, movement){
	// movment speed
	var _horz = (movement[RIGHT] - movement[LEFT]);
	var _vert = (movement[DOWN] - movement[UP]);
	var _face = -1;
	
	// handle no movement
	if (_horz == 0 && _vert == 0){
		_face = -1;
	}
	// find the direction and handle
	else {
		if (_horz > 0){
			_face = RIGHT;
		}
	
		if (_vert < 0){
			_face = UP;	
		}
	
		if (_horz < 0){
			_face = LEFT;
		}
	
		if (_vert > 0){
			_face = DOWN;
		}
	}
	
	// set sprite
	if (_face > -1){
		sprite_index = sprite[_face];
	}
}