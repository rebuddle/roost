// cooldowns
if (dash_cd > 0) {
	dash_cd--;
}

// execute fsm
fsm.step();

if (place_meeting(x, y, obj_bullet)) {
	instance_destroy();	
}