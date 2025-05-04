// _weapon.gml
function WEAPON(_name, _type, _damage, _attack_speed, _range, _slash_speed, _spr_slash) constructor {
		// assigned variables
		owner = obj_player
		object = obj_projectile;
		sprite = _spr_slash;
        name= _name;
		type= _type;
        base_damage= _damage;
        attack_speed= _attack_speed;
		slash_speed= _slash_speed;
        range= _range;
		cooldown= 0;
		
		// methods
		attack= _weapon_attack;
		cooldowns=_weapon_cooldowns;
}

function _weapon_attack() {
	// create slash
	if (cooldown <= 0) {
		var slash = instance_create_depth(owner.x, owner.y, owner.depth - 1, object);
		// update slash properties
		slash.alarm[0] = range*3;
		slash.sprite_index = sprite;
		slash.damage = base_damage;
		slash.spd = slash_speed;
		
		// add cooldown of attack
		cooldown = 60/(attack_speed);
	}
}

function _weapon_cooldowns() {
	if (cooldown > 0) {
		cooldown--;
	}
}

// initialize weapon list
global.weapon_list = {
		// weapons // _name, _type, _damage, _attack_speed, _range, _spr_slash
	    "sword": new WEAPON("sword", "weapon", 3, 3, 3, 8, spr_projectile)
};


