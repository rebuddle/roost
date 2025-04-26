spwn_cd--;

if (!instance_exists(obj_player)) {
	instance_destroy();
}

if (spwn_cd < 0) {
	var w = irandom(4);
	var _obj = obj_enemy;
	var _offset = 64;
	switch(w)
	{ // pick a random wall to spawn on
		case 0:
			global.enemy_list[$ "pink_box"].spawn(_offset, _offset, depth+1);
			instance_create_depth(_offset, irandom(room_height-_offset), depth+1, _obj);
			break;
		
		case 1:
			global.enemy_list[$ "pink_box"].spawn(_offset, _offset, depth+1);
			instance_create_depth(room_width-_offset, irandom(room_height-_offset), depth+1, _obj);
			break;
		
		case 2:
			global.enemy_list[$ "pink_box"].spawn(_offset, _offset, depth+1);
			instance_create_depth(irandom(room_width-_offset), _offset, depth+1, _obj);
			break;
		
		case 3:
			global.enemy_list[$ "pink_box"].spawn(_offset, _offset, depth+1);
			instance_create_depth(irandom(room_width-_offset), room_height-_offset, depth+1, _obj);
			break;
	}
	
	// reset cd
	spwn_cd = 120;
}