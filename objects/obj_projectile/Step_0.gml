// update projectile
projectile.update();

if place_meeting(x, y, obj_enemy){
	show_debug_message("BING");
	instance_destroy();
}