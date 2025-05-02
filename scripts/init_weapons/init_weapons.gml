
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
		// player attacks // damage, attack_speed, range
	    "sword": _add_weapon("Sword", "weapon", spr_sword, 2, 10, 5, obj_slash, spr_slash),
		"bow": _add_weapon("Bow", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"staff": _add_weapon("Staff", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"bomb": _add_weapon("Bomb", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash)
		
		// enemy attacks
		//"enemy_strike": _add_weapon("Enemy Strike", 2, 30, 90, obj_enemy_attack, spr_bullet)
};

/*
global.my_gear = [
    { name: "Sword", icon: spr_sword, type: "Weapon", stats: "Level 1", exp: 45, exp_max: 100 },
    { name: "Shield", icon: spr_shield, type: "Weapon", stats: "Level 1", exp: 45, exp_max: 100 },
	//{ name: "Helm", icon: spr_extra, type: "Armor", stats: "Level 1" },
	{ name: "Armor", icon: spr_armor, type: "Armor", stats: "Level 1" },
    { name: "Boots", icon: spr_boots, type: "Accessory", stats: "Level 1" }
];
*/