function PROJECTILE() constructor {
	/* variables */
	owner = obj_player;
	object = obj_projectile;
	sprite = spr_projectile;
	dir = point_direction(object.x, object.y, mouse_x, mouse_y); 
	spd = 5;
	damage = 1;
	
	/* initialization */
	init = function (_owner, _sprite_index, _damage, _spd, _range) {
		owner = _owner;
		sprite = _sprite_index;
		spd = _spd;
		damage = _damage;
		object.alarm[0] = _range;
	}
	
	/* methods */
	// draw	
	draw = function () {
		draw_sprite_ext(sprite, 0, object.x, object.y, 1, 1, dir -90, c_white, 1);
	}
	
	// update
	update = function () {
		// projectile
		var xspd = lengthdir_x( spd, dir);
		var yspd = lengthdir_y( spd, dir);

		object.x += xspd;
		object.y += yspd;

		with (object) {
			if (place_meeting(x, y, obj_wall)) {
				instance_destroy()
			}
		}

		// trail effect
		var trail = instance_create_depth(object.x, object.y, object.depth+1, obj_projectile_trail)
		trail.sprite_index= spr_projectile_trail;
		trail.image_blend = c_white;
		trail.image_alpha = 0.8;
		trail.dir = dir;
		trail.image_angle = dir - 90;
	}


}