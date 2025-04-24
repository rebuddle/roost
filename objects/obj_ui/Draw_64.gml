draw_text_transformed(40,20,string(global.score),3,3, image_angle);

if (!instance_exists(obj_player)) {
	draw_text_transformed(room_width/2 + 20,room_height/2 + 20,"Game Over!",3,3, image_angle);
}