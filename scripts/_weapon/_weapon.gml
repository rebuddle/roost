// _weapon.gml
function WEAPON(_name, _type, _damage, _attack_speed, _range, _slash_speed, _spr_slash, _spr_trail, _amplitude, _num_shots) constructor {
		/* variables */
		owner = obj_player;
		object = obj_projectile;
		sprite = _spr_slash;
		sprite_trail = _spr_trail;
        name= _name;
		type= _type;
        base_damage= _damage;
        attack_speed= _attack_speed;
		slash_speed= _slash_speed;
        range= _range;
		cooldown= 0;
		num_shots = _num_shots;
		amplitude=_amplitude;
		curve_coeff=1;
		
		
		/* methods */
		// attack
		attack= function () {
			// create slash
			if (cooldown <= 0) {
				for (var i=0; i<num_shots; i++){
					// create slash object
					var slash = instance_create_depth(owner.x, owner.y, owner.depth, object);
					/* need to be upgraded sprite version */
					//slash.projectile.init(owner, sprite, sprite_trail, base_damage, slash_speed, range*3, amplitude, curve_coeff); 
					slash.alarm[0] = range*3;
					slash.sprite_index = sprite;
					slash.projectile.owner = owner;
					slash.projectile.sprite = sprite;
					slash.projectile.sprite_trail = sprite_trail;
					slash.projectile.slash_speed = slash_speed;
					slash.projectile.range = range;
					slash.projectile.amplitude = amplitude;
					slash.projectile.dir = point_direction(owner.x, owner.y, mouse_x, mouse_y); 
					slash.projectile.num_shots = num_shots;
					slash.projectile.curve_coeff = i; //curve_coeff;
					
					/* dumb sprite version */
					/*
					slash.sprite_index = sprite;
					slash.sprite_trail = sprite_trail;
					slash.curve_coeff = curve_coeff;
					slash.alarm[0] = range*3;
					*/
					
					//curve_coeff *= -1;
				}
		
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
	    "sword": new WEAPON("sword", "weapon", 3, 3, 5, 4, spr_sword, spr_sword_trail, 0, 1),
		"staff": new WEAPON("staff", "weapon", 3, 2, 15, 4, spr_staff, spr_staff_trail, 0, 1)
};


