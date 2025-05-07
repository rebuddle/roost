
/* Score */
// draw score
//draw_text_transformed(room_width/2,32, "Level:" + string(obj_enemyspawn._level),2,2, image_angle);
draw_text_transformed(room_width/2,64, "Projectiles:" + string(instance_number(obj_projectile)),2,2, image_angle);
/* end */

if (!instance_exists(obj_player)) {
	// player doesn't exist prompt Game Over!
	/* Game Over */
	draw_text_transformed(room_width/2 - 64,room_height/2,"Game Over!",3,3, image_angle);
	/* end */
} else {
	
	/* Draw Hearts as HealthBar */
	// draw hp
	var heart_init_x = 32;
	var heart_init_y  = 16;
	var heart_width = 64;
	var heart_height = 64;
	
	// draw background
	draw_set_alpha(0.5);
	draw_set_color(c_white);
	draw_rectangle(heart_init_x - 6, heart_init_y + 12, heart_init_x + (obj_player.player.max_hp/2)*heart_width + 4 ,heart_init_y + heart_height + 6, false);
	draw_set_alpha(1);

	// drawing the current number of lives
	for (var i = 0; i < obj_player.player.max_hp; i+=2) {
	    var heart_x = heart_init_x + heart_width * i/2;
	    var heart_y = heart_init_y;
		var img_index = 0;
		if (i == obj_player.player.hp - 1){
			img_index = 1;
		} else if (i > obj_player.player.hp - 2) {
			img_index = 2;
		}
	    draw_sprite_stretched(spr_hp, img_index, heart_x, heart_y, heart_width, heart_height);
	}
	/* end */
}
