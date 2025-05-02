function _script_cooldowns(){
		// update cooldown
		if player_manager.lhand.cooldown > 0 {
			player_manager.lhand.cooldown--;
		}
		if player_manager.rhand.cooldown > 0 {
			player_manager.rhand.cooldown--;	
		}
		if player_manager.dash_cooldown > 0 {
			player_manager.dash_cooldown--;
		}
}