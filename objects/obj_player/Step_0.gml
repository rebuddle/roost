// cooldowns
if (dash_cd > 0) {
	dash_cd--;
}

// execute fsm
fsm.step();

// hit with bullet
if (place_meeting(x, y, obj_bullet) && fsm.state != "dash") {
	global.hp--;
	instance_destroy(instance_nearest(x,y,obj_bullet));
}

// hit by enemy
if (place_meeting(x, y, obj_enemy1) && fsm.state != "dash") {
	global.hp--;
	instance_destroy(instance_nearest(x,y,obj_enemy1));	
}

// game over!!
if global.hp <=0 {
	instance_destroy();
}