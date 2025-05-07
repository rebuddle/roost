// create projectile
dir = point_direction(x, y, mouse_x, mouse_y); 
spd = 8;
damage = 1;
range = 15;
alarm[0] = 15;
t=0;
amplitude = 1;
curve_coeff = 1;


/* initialization */
/*
init = function (_owner, _sprite_index, _sprite_trail, _damage, _spd, _range, _amplitude, _curve_coeff) {
	owner = _owner;
	sprite = _sprite_index;
	sprite_trail = _sprite_trail;
	spd = _spd;
	damage = _damage;
	range = _range;
	amplitude = _amplitude;
	curve_coeff = _curve_coeff;
}
*/