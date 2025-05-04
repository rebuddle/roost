// collision trigger
if place_meeting(x,y,obj_player_old){
	room_goto(target_rm);
	obj_player_old.x = target_x;
	obj_player_old.y = target_y;
}