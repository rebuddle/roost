spwn_cd--;

if (!instance_exists(obj_player)) {
	instance_destroy();
}

if (spwn_cd < 0) {
	var w = irandom(4);
	var _obj = obj_food;
	
	// spawn objects
	instance_create_depth(irandom(room_width-20), irandom(room_height-20), depth+2, _obj);
	
	// reset cd
	spwn_cd = 120;
}