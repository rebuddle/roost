
// move towards player
if (instance_exists(obj_player)){
	// taking damage
	if place_meeting(x, y, obj_slash){
		instance_destroy(obj_slash);
		hp--;
		
	}
	if (hp <= 0) {
		global.score++;
		instance_destroy();
	}

	// movement
	horz = obj_player.x - x;
	vert = obj_player.y - y;
	_player_movement()
}
