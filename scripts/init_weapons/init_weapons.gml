
// function to build out weapons
function _add_weapon(_name, _type, _icon, _damage, _attack_speed, _range, _obj_slash, _slash_sprite) {
    return {
		// assigned variables
        name: _name,
		type: _type,
		icon: _icon,
        base_damage: _damage,
        attack_speed: _attack_speed,
        range: _range,
		cooldown: 0,
		
		// slash pathing and sprite
        slash_object: obj_slash,
		slash_sprite: _slash_sprite,
		
		// level up weapon
		level: 1,
		xp: 0,
		max_xp: 100,
		add_xp: function(_xp){
			self.xp += _xp;	
			if self.xp >= self.max_xp {
				self.level_up();
			}
		},
		level_up: function(){
			self.level++;
			self.xp = self.xp%self.max_xp;
			self.max_xp = self.max_xp*1.25
			
			// stat boost
			self.range++;
			self.base_damage++;
			self.attack_speed++;
		}
		
    };
}

// build out armor
global.weapon_list = {
		// player attacks // name, type, damage, attack_speed, range, projectile path, projectile sprite
	    "sword": _add_weapon("Sword", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"bow": _add_weapon("Bow", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"staff": _add_weapon("Staff", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"bomb": _add_weapon("Bomb", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash)
};
