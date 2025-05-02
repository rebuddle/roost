if (_spwn_cd > 0) {
	_spwn_cd--;
}

if (!instance_exists(obj_player)) {
	instance_destroy();
}

if (_spwn_cd <= 0){
	// establish variables
	var w = irandom(3);
	var enemy = levels[_level].enemies[random(array_length(levels[_level].enemies))];
	var _obj = obj_enemy;
	var _offset = 96;
	
	show_debug_message(enemy);
	show_debug_message(global.enemy_list[$ enemy]);
	switch(w)
	{ // pick a random wall to spawn on
		case 0:
			global.enemy_list[$ enemy].spawn(_offset, _offset, depth+1);
			//instance_create_depth(_offset, irandom(room_height-_offset), depth+1, _obj);
			break;
		
		case 1:
			global.enemy_list[$ enemy].spawn(_offset, _offset, depth+1);
			//instance_create_depth(room_width-_offset, irandom(room_height-_offset), depth+1, _obj);
			break;
		
		case 2:
			global.enemy_list[$ enemy].spawn(_offset, _offset, depth+1);
			//instance_create_depth(irandom(room_width-_offset), _offset, depth+1, _obj);
			break;
		
		case 3:
			global.enemy_list[$ enemy].spawn(_offset, _offset, depth+1);
			//instance_create_depth(irandom(room_width-_offset), room_height-_offset, depth+1, _obj);
			break;
	}
	
	// reset cd
	_spwn_cd = levels[_level].spawn_cd;
	_cnt++;
	
	if (_cnt >= levels[_level].spawn_cnt) {
		_level++;
		_cnt = 0;
	}
}