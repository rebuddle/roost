spwn_cd--;

if (spwn_cd < 0) {
	instance_create_depth(irandom(room_width), irandom(room_height), depth+1, obj_bullet);
	spwn_cd = 30;
}