
// function to build out weapons
function _add_weapon(_name, _damage, _attack_speed, _range, _slash_sprite) {
    return {
		// assigned variables
        name: _name,
        base_damage: _damage,
        attack_speed: _attack_speed,
        range: _range,
		
        //slash_object: obj_slash,
		slash_sprite: _slash_sprite
    };
}

// build out armor
global.weapon_list = {
		// player attacks
	    "iron_sword": _add_weapon("Iron Sword", 5, 60, 30, spr_slash_small),
		"iron_dagger": _add_weapon("Iron Dagger", 5, 10, 15, spr_slash)
		
		// enemy attacks
		//"enemy_strike": _add_weapon("Enemy Strike", 2, 30, 90, obj_enemy_attack, spr_bullet)
};