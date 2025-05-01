// cooldowns
player_manager.step_cooldowns();

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


/* Slash Sprite Browser */
// press to change sprite index
// used for browsing slash sprites:D
next_key = keyboard_check(ord("E"));
previous_key = keyboard_check(ord("Q"));
var catalog_len = sprite_get_number(spr_slash);
if (next_key && !pressed) {
	global.img_i = (global.img_i + 1)%catalog_len;
	pressed = true;
}

if (previous_key && !pressed) {
	global.img_i = (global.img_i - 1)%catalog_len;
	pressed = true;
}

if (!next_key && !previous_key) {
	pressed = false;
}
/* end */