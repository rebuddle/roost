xspd = lengthdir_x( spd, dir);
yspd = lengthdir_y( spd, dir);

x += xspd;
y += yspd;

if (place_meeting(x, y, obj_wall)) {
	instance_destroy()
}


// trail effect
with (instance_create_depth(x, y, depth+1, obj_slash_trail)){
	//image_blend = c_silver;
	sprite_index=spr_slash;
	image_blend = c_white;
	image_alpha = 0.8;
}
