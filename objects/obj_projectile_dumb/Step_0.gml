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

x += xspd + perp_x*amplitude;
y += yspd + perp_y*amplitude;


if (place_meeting(x, y, obj_enemy)) {
	show_debug_message("BING!");
	instance_destroy();
}

// trail effect
var trail = instance_create_depth(x, y, depth, obj_projectile_trail)
trail.sprite_index= sprite_trail;
trail.image_blend = c_white;
trail.image_alpha = 0.8;
trail.dir = dir;
trail.image_angle = dir - 90;