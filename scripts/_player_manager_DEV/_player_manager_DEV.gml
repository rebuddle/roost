// not going to be used, but cool as reference in case I change my mind in the future
function hero(_hp=6, _attack=5, _dexterity=5, _defence=5, _vitality=5, _wisdom=5, _move_speed=5, // stats
				_dash_cooldown=0, // cooldowns
				_lhand=noone, _rhand=noone, _helm=noone, _armor=noone, _boots=noone, // gear
				) constructor {
	// resource stats
	max_hp= _hp;
	hp= _hp;
	// base stats
	attack= _attack;
	dexterity= _dexterity;
	defence= _defence;
	vitality= _vitality;
	wisdom= _wisdom;
	move_speed= _move_speed;
	
	// cooldowns
	dash_cooldown= _dash_cooldown;
	
	// gear
	lhand= _lhand;
	rhand= _rhand;
	helm= _helm;
	armor= _armor;
	boots= _boots;

	// methods
	player_cooldowns = _player_cooldowns;
	player_attack = _player_attack;
}

function _player_cooldowns(){
		// update cooldown
		if lhand.cooldown > 0 {
			lhand.cooldown--;
		}
		if rhand.cooldown > 0 {
			rhand.cooldown--;	
		}
		if dash_cooldown > 0 {
			dash_cooldown--;
		}
}

function _player_attack(_x, _y, _depth){
	lhand.attack(_x, _y, _depth);
	rhand.attack(_x, _y, _depth);
}