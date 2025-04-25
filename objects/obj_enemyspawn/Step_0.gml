spwn_cd--;

if (!instance_exists(obj_player)) {
	instance_destroy();
}

if (spwn_cd < 0) {
	var w = irandom(4);
	var _obj = obj_enemy1;
	
	// spawn objects
	instance_create_depth(irandom_range(64, room_width-64), irandom_range(64, room_height-64), depth+2, _obj);
	
	// reset cd
	spwn_cd = 120;
}