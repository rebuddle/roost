function _script_attack(_x, _y, _depth) {
	player_manager.lhand.attack(_x, _y, _depth+1);
	player_manager.rhand.attack(_x, _y, _depth+1);
}