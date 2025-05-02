
// move towards player
if (instance_exists(obj_player)){
	// taking damage
	if place_meeting(x, y, obj_slash){
		var damage = max(irandom(obj_slash.damage) - irandom(defence), 0);
		hp-= damage
		instance_destroy(obj_slash);
		
		var dmg_text = instance_create_depth(x+16, y-16, depth-10, obj_show_damage);
		dmg_text.damage = damage;
	}
	
	// enemy destroyed
	if (hp <= 0) {
		global.score++;
		obj_player.player_manager.lhand.add_xp(15);
		instance_destroy();
	}

	// movement
	horz = obj_player.x - x;
	vert = obj_player.y - y;
	_script_movement(horz, vert, move_speed);
	
	// will need to modify to state machine, but for now this should work
	//global.weapon_list[$ weapon].attack(x, y, depth);
}
