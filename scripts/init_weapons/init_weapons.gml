
// function to build out weapons
function _add_weapon(_name, _damage, _attack_speed, _slash_speed, _range, _slash_object, _slash_sprite) {
    return {
		// assigned variables
        name: _name,
        damage: _damage,
        attack_speed: _attack_speed,
		slash_speed: _slash_speed,
        range: _range,
		
		// sprite and object control
        //sprite: _sprite,
        slash_object: _slash_object,
		slash_sprite: _slash_sprite,
		
		owner: noone,
		
		// who is wielding the weapon?
		equip: function(_obj) {
			self.owner = _obj;
		},
		
		// internal variables
		attack_cooldown: 0,
        
		// attack function
        attack: function(_x, _y, _depth) {
			// update cooldown
			self.step();
			
			if (self.attack_cooldown <= 0) {
				// create attack and assign vars
				var slash = instance_create_depth(_x, _y, _depth+1, self.slash_object);
				slash.alarm[0] = self.range;
				slash.spd = self.slash_speed;
				slash.sprite_index = self.slash_sprite;
				slash.damage = self.damage;
				
				// refresh cooldown
				self.attack_cooldown = self.attack_speed;
			}
        },
		
		// cooldown and possibly something else
		step: function() {
			if (attack_cooldown > 0) {
				self.attack_cooldown--;
			}
		}
    };
}

// build out armor
global.weapon_list = {
		// player attacks
	    "iron_sword": _add_weapon("Iron Sword", 5, 60, 15, 30, obj_slash, spr_slash_small),
		"iron_dagger": _add_weapon("Iron Dagger", 5, 10, 15, 15, obj_slash, spr_slash),
		
		// enemy attacks
		"enemy_strike": _add_weapon("Enemy Strike", 2, 30, 8, 90, obj_enemy_attack, spr_bullet)
};