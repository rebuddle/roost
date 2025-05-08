function PROJECTILE() constructor {
	/* variables */
	owner = obj_player;
	object = obj_projectile;
	sprite = spr_sword;
	dir = 0; 
	spd = 5;
	damage = 1;
	range = 15;
	amplitude = 1;
	num_shots = 1;
	curve_coeff = 1;
	t=0;
	
	x = owner.x;
	y = owner.y;
	depth = owner.depth;
	
	active = true;
	
	/* methods */
	// draw	
	draw = function () {
		// destroyed?
		if !active return;
		draw_sprite_ext(sprite, 0, x, y, 1, 1, dir -90, c_white, 1);
	}
	
	// update
	update = function () {
		// destroyed?
		if !active return;
		
		// projectile
		var xspd = lengthdir_x( spd, dir);
		var yspd = lengthdir_y( spd, dir);
		
		/*
		if (t >= range div 2)
		{
			curve_coeff *= -1;
			t = 0;
		}
		t++;
		*/
		
		var proj_angle = -180*(curve_coeff/num_shots) + 90
	
		var perp_x = lengthdir_x(spd, dir + proj_angle);
		var perp_y = lengthdir_y(spd, dir + proj_angle);

		x += xspd + perp_x*amplitude;
		y += yspd + perp_y*amplitude;

		with (object) {
			if (place_meeting(x, y, obj_enemy)) {
				show_debug_message("BING!");
			}
		}
		
		
		// collision with drawing
		var hit = point_distance(x, y, obj_enemy.x, obj_enemy.y); // <46
		if (hit <= 46) {
			show_debug_message(hit);
			active = false;
		}

		// trail effect
		var trail = instance_create_depth(x, y, depth, obj_projectile_trail)
		trail.sprite_index= sprite_trail;
		trail.image_blend = c_white;
		trail.image_alpha = 0.8;
		trail.dir = dir;
		trail.image_angle = dir - 90;
	}

}