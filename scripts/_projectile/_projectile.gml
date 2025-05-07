function PROJECTILE() constructor {
	/* variables */
	owner = obj_player;
	object = obj_projectile;
	sprite = spr_sword;
	dir = point_direction(object.x, object.y, mouse_x, mouse_y); 
	spd = 5;
	damage = 1;
	range = 15;
	amplitude = 1;
	curve_coeff = 1;
	t=0;
	
	/*
	x = owner.x;
	y = owner.y;
	depth = owner.depth;
	*/
	
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
	
	/* methods */
	// draw	
	/*
	draw = function () {
		draw_sprite_ext(sprite, 0, x, y, 1, 1, dir -90, c_white, 1);
	}
	*/
	
	// update
	update = function () {
		// projectile
		var xspd = lengthdir_x( spd, dir);
		var yspd = lengthdir_y( spd, dir);
		
		if (t >= range div 2)
		{
			curve_coeff *= -1;
			t = 0;
		}
		t++;
		
		var perp_x = lengthdir_x(spd, dir+ (90*curve_coeff));
		var perp_y = lengthdir_y(spd, dir+ (90*curve_coeff));

		object.x += xspd + perp_x*amplitude;
		object.y += yspd + perp_y*amplitude;

		with (object) {
			if (place_meeting(x, y, obj_enemy)) {
				show_debug_message("BING!");
			}
		}

		// trail effect
		var trail = instance_create_depth(object.x, object.y, object.depth, obj_projectile_trail)
		trail.sprite_index= sprite_trail;
		trail.image_blend = c_white;
		trail.image_alpha = 0.8;
		trail.dir = dir;
		trail.image_angle = dir - 90;
	}

}