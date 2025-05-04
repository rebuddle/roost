// projectile
var xspd = lengthdir_x( spd, dir);
var yspd = lengthdir_y( spd, dir);

x += xspd;
y += yspd;

if (place_meeting(x, y, obj_wall)) {
	instance_destroy()
}

// trail effect
var trail = instance_create_depth(x, y, depth+1, obj_projectile_trail)
//image_blend = c_silver;
trail.sprite_index= spr_projectile_trail;
trail.image_blend = c_white;
trail.image_alpha = 0.8;
trail.dir = dir;
trail.image_angle = dir - 90;