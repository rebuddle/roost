spwn_cd--;

if (!instance_exists(obj_player)) {
	instance_destroy();
}

if (spwn_cd < 0) {
	var w = irandom(4);
	var _obj = obj_bullet;
	switch(w)
	{ // pick a random wall to spawn on
		case 0:
			instance_create_depth(0, irandom(room_height), depth+1, _obj);
			break;
		
		case 1:
			instance_create_depth(room_width, irandom(room_height), depth+1, _obj);
			break;
		
		case 2:
			instance_create_depth(irandom(room_width), 0, depth+1, _obj);
			break;
		
		case 3:
			instance_create_depth(irandom(room_width), room_height, depth+1, _obj);
			break;
	}
	
	// reset cd
	spwn_cd = 5;
}