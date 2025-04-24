// cooldowns
if (dash_cd > 0) {
	dash_cd--;
}

// execute fsm
fsm.step();

if (place_meeting(x, y, obj_bullet) && fsm.state != "dash") {
	instance_destroy();	
}