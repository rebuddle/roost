// _weapon.gml
function WEAPON(_name, _type, _damage, _attack_speed, _range, _slash_speed, _spr_slash) constructor {
		/* variables */
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
		
		/* methods */
		// attack
		attack= function () {
			// create slash
			if (cooldown <= 0) {
				var slash = instance_create_depth(owner.x, owner.y, owner.depth - 1, object);
				// _owner, _sprite_index, _damage, _spd, _range
				slash.projectile.init(owner, sprite, base_damage, slash_speed, range*3); 
		
				// add cooldown of attack
				cooldown = 60/(attack_speed);
			}
		}
		
		// cooldown
		cooldowns= function () {
			if (cooldown > 0) {
				cooldown--;
			}	
		}
}

// initialize weapon list
global.weapon_list = {
		// weapons // _name, _type, _damage, _attack_speed, _range, _spr_slash
	    "sword": new WEAPON("sword", "weapon", 3, 3, 3, 8, spr_projectile)
};


