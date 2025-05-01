dir = point_direction(x, y, mouse_x, mouse_y); 
image_angle = dir - 90; // might need to move to begin step for error handling

// variables to trigger image index change
/* Sprite Browser */
image_index = global.img_i;