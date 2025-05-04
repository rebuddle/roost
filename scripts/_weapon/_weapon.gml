
// function to build out weapons
function weapon(_name, _type, _icon, _damage, _attack_speed, _range, _obj_slash, _slash_sprite) constructor {
		// assigned variables
        name= _name;
		type= _type;
		icon= _icon;
        base_damage= _damage;
        attack_speed= _attack_speed;
        range= _range;
		cooldown= 0;
		// slash pathing and sprite
        slash_object= obj_slash;
		slash_sprite= _slash_sprite;
		// level up weapon
		level= 1;
		xp= 0;
		max_xp= 100;
		// methods
		add_xp= _add_xp;
		attack= _attack;
}	

function _add_xp(_xp) {
	xp += _xp;	
	// level up
	if xp >= max_xp {
		_level_up();
	}	
}

function _level_up(){
	// set new xp
	level++;
	xp = xp % max_xp;
	max_xp = max_xp*1.25
	// stat boost
	range++;
	base_damage++;
	attack_speed++;
	
	// pause game
	//instance_deactivate_all(true);
}


function _attack(_x, _y, _depth) {
		// init vars
		var weapons = [ obj_player_old.player_manager.lhand
					  , obj_player_old.player_manager.rhand];
		var weapons_cooldown = [ obj_player_old.player_manager.lhand.cooldown
							   , obj_player_old.player_manager.rhand.cooldown];
		
		// exit if noone
		if (!weapons[0] && !weapons[1]) {
			return;
		}
		
		// create slash
		for (i=0;i<array_length(weapons);i++){
			if (weapons_cooldown[i] <= 0) {
				var slash = instance_create_depth(_x, _y, _depth, weapons[i].slash_object);
				// update slash properties
				slash.owner = weapons[i];
				slash.alarm[0] = weapons[i].range;
				slash.sprite_index = weapons[i].slash_sprite;
				slash.damage = weapons[i].base_damage;
				slash.spd = 5;
			
				// add cooldown of attack
				weapons_cooldown[i] = 600/(weapons[i].attack_speed);
				if (i == 0) {
					obj_player_old.player_manager.lhand.cooldown = 600/(weapons[i].attack_speed);
				} else {
					obj_player_old.player_manager.rhand.cooldown = 600/(weapons[i].attack_speed);
				}
			}
		}
}


// build out weapon list
global.weapon_list = {
		// player attacks // name, type, damage, attack_speed, range, projectile path, projectile sprite
	    "sword": new weapon("Sword", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash),
		"bow": new weapon("Bow", "weapon", spr_sword, 5, 10, 15, obj_slash, spr_slash)
};

