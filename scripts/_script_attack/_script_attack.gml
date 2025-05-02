function _script_attack(_x, _y, _depth) {
		// init vars
		var weapons = [ obj_player.player_manager.lhand
					  , obj_player.player_manager.rhand];
		var weapons_cooldown = [ obj_player.player_manager.lhand.cooldown
							   , obj_player.player_manager.rhand.cooldown];
		
		// exit if noone
		if (!weapons[0] && !weapons[1]) {
			return;
		}
		
		// create slash
		for (i=0;i<array_length(weapons);i++){
			if (weapons_cooldown[i] <= 0) {
				var slash = instance_create_depth(_x, _y, _depth, weapons[i].slash_object);
				// update slash properties
				slash.alarm[0] = weapons[i].range;
				slash.sprite_index = weapons[i].slash_sprite;
				slash.damage = weapons[i].base_damage;
				slash.spd = 5;
			
				// add cooldown of attack
				weapons_cooldown[i] = 600/(weapons[i].attack_speed);
				if (i == 0) {
					obj_player.player_manager.lhand.cooldown = 600/(weapons[i].attack_speed);
				} else {
					obj_player.player_manager.rhand.cooldown = 600/(weapons[i].attack_speed);
				}
			}
		}
}