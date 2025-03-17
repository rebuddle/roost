// controls
movement = [keyboard_check(ord("D"))
	, keyboard_check(ord("W"))
	, keyboard_check(ord("A"))
	, keyboard_check(ord("S"))];

// invoke player movement
player_movement(x_sp, y_sp, move_sp, move_dir, movement);

// invoke player animation
player_animation(sprite, movement);
