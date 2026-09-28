// create projectile
instance_create_depth(x, y, depth, obj_projectile_trail, {
    sprite_index: spr_sword_trail_1,
    image_blend: c_white,
    image_alpha: 0.8,
    direction: direction,
    image_angle: image_angle,
    speed: speed
});