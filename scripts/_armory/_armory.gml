
// function to build out weapons
function _add_weapon(_name, _damage, _attack_speed, _range, _slash_object, _slash_sprite) {
    return {
        name: _name,
        damage: _damage,
        attack_speed: _attack_speed,
        range: _range,
        //sprite: _sprite,
        slash_object: _slash_object,
		slash_sprite: _slash_sprite,
        
        attack: function(_x, _y, _depth) {
			var slash = instance_create_depth(_x, _y, _depth+1, self.slash_object);
			slash.alarm[0] = self.range;
			slash.spd = self.attack_speed;
			slash.sprite_index = self.slash_sprite;
        }
    };
}

// build out armor
global.weapon_list = {
	    "iron_sword": _add_weapon("Iron Sword", 1, 15, 30, obj_slash, spr_slash_small),
		"iron_dagger": _add_weapon("Iron Dagger", 1, 10, 15, obj_slash, spr_slash)
};