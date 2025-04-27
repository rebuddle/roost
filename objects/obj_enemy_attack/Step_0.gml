// update direction based on player
/*
if (instance_exists(obj_player)) {
	dir = point_direction(x, y, obj_player.x, obj_player.y); 
}
*/

xspd = lengthdir_x( spd, dir);
yspd = lengthdir_y( spd, dir);

x += xspd;
y += yspd;

if (place_meeting(x, y, obj_wall)) {
	instance_destroy()
}