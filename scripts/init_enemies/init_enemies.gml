// function to build out weapons
function _add_enemy(_name, _max_hp, _move_speed, _damage, _attack_speed, _defence, _obj_enemy, _spr_enemy) {
    return {
        name: _name,
		max_hp: _max_hp,
		move_speed: _move_speed,
		damage: _damage,
		attack_speed: _attack_speed,
		defence: _defence,
		enemy_object: _obj_enemy,
		enemy_sprite: _spr_enemy,
		
		spawn: function(_x, _y, _depth) {
			var enemy = instance_create_depth(_x, _y, _depth+1, self.enemy_object);
			enemy.max_hp = self.max_hp;
			enemy.hp = self.max_hp;
			enemy.move_speed = self.move_speed;
			enemy.sprite_index = self.enemy_sprite;
		}
    };
}

// build out armor
global.enemy_list = {
		"green_box": _add_enemy("Green Box", 5, 8, 1, 1, 0, obj_enemy, spr_enemy),
		"pink_box": _add_enemy("Pink Box", 10, 4, 1, 1, 0, obj_enemy, spr_enemy_1)
};