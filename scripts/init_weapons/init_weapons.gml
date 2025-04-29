
// function to build out weapons
function _add_weapon(_name, _damage, _attack_speed, _range, _obj_slash, _slash_sprite) {
    return {
		// assigned variables
        name: _name,
        base_damage: _damage,
        attack_speed: _attack_speed,
        range: _range,
		
		// slash pathing and sprite
        slash_object: obj_slash,
		slash_sprite: _slash_sprite
    };
}

// build out armor
global.weapon_list = {
		// player attacks
	    "sword": _add_weapon("Sword", 5, 60, 30, obj_slash, spr_slash_small),
		"bow": _add_weapon("Bow", 5, 10, 15, obj_slash, spr_slash),
		"staff": _add_weapon("Staff", 5, 10, 15, obj_slash, spr_slash),
		"bomb": _add_weapon("Bomb", 5, 10, 15, obj_slash, spr_slash)
		
		// enemy attacks
		//"enemy_strike": _add_weapon("Enemy Strike", 2, 30, 90, obj_enemy_attack, spr_bullet)
};