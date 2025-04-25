// cooldowns
if (dash_cd > 0) {
	dash_cd--;
}

// execute fsm
fsm.step();

// hit with bullet
if (place_meeting(x, y, obj_bullet) && fsm.state != "dash") {
	instance_destroy();	
}

// hit by enemy
if (place_meeting(x, y, obj_enemy1) && fsm.state != "dash") {
	instance_destroy();	
}