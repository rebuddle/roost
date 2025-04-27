// cooldowns
if (dash_cd > 0) {
	dash_cd--;
}

// execute fsm
fsm.step();

// hit with bullet
if (place_meeting(x, y, obj_enemy_attack) && fsm.state != "dash") {
	player_manager.hp -= max(irandom(obj_enemy_attack.damage) - irandom(player_manager.defence), 0);
	instance_destroy(instance_nearest(x,y,obj_enemy_attack));
}

// hit by enemy
if (place_meeting(x, y, obj_enemy) && fsm.state != "dash") {
	player_manager.hp--;
	instance_destroy(instance_nearest(x,y,obj_enemy));	
}

// game over!!
if player_manager.hp <=0 {
	instance_destroy();
}