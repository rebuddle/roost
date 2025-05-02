// cooldowns
// player_manager.step_cooldowns();
_script_cooldowns();

// execute fsm
fsm.step();

// hit by enemy
if (place_meeting(x, y, obj_enemy) && fsm.state != "dash") {
	player_manager.hp--;
	instance_destroy(instance_nearest(x,y,obj_enemy));	
}

// game over!!
if player_manager.hp <=0 {
	instance_destroy();
}