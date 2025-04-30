
/* Score */
// draw score
draw_text_transformed(room_width/2,32, "Kills:" + string(global.score),2,2, image_angle);
/* end */

if (!instance_exists(obj_player)) {
	// player doesn't exist prompt Game Over!
	/* Game Over */
	draw_text_transformed(room_width/2 - 64,room_height/2,"Game Over!",3,3, image_angle);
	/* end */
} else {
	
	// player does exist and it's time to play
	/* whiteboard [testing ui] */
	// draw_text_transformed(40,120,"hp:" + string(obj_player.player_manager.hp),3,3, image_angle);
	/* end */


	/* Draw Hearts as HealthBar */
	// draw hp
	var heart_init_x = 32;
	var heart_init_y  = 32;
	var heart_width = 64;
	var heart_height = 64;

	// drawing the current number of lives
	for (var i = 0; i < obj_player.player_manager.max_hp; i+=2) {
	    var heart_x = heart_init_x + heart_width * i/2;
	    var heart_y = heart_init_y;
		var img_index = 0;
		if (i == obj_player.player_manager.hp - 1){
			img_index = 1;
		} else if (i > obj_player.player_manager.hp - 2) {
			img_index = 2;
		}
	    draw_sprite_stretched(spr_hp, img_index, heart_x, heart_y, heart_width, heart_height);
	}
	/* end */
}
