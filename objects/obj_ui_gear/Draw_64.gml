// Example gear struct
global.my_gear = [
    //{ name: "Sword", icon: spr_sword, type: "Weapon", stats: "Level 1", exp: 45, exp_max: 100 },
    { name: "Shield", icon: spr_shield, type: "Weapon", level: 1, exp: 45, exp_max: 100 },
	//{ name: "Helm", icon: spr_extra, type: "Armor", stats: "Level 1" },
	{ name: "Armor", icon: spr_armor, type: "Armor", level: 1 },
    { name: "Boots", icon: spr_boots, type: "Accessory", level: 1 }
];

// obj_ui - Draw GUI Event
var gear_list = array_concat([obj_player.player_manager.lhand], global.my_gear);
var _x = room_width;
var _y = 50;
var spacing = 100;

for (var i = 0; i < array_length(gear_list); i++) {
    var item = gear_list[i];
	var item_y = _y + i * spacing;
	
	// draw background
	draw_set_alpha(0.5);
	draw_set_color(c_white);
	draw_rectangle(_x - 6, _y + i * spacing - 12, _x + 120, _y + (i+1) * spacing - 30, false);
	draw_set_alpha(1);

	// draw gear slot
    draw_sprite(item.icon, 0, _x, _y + i * spacing);
    draw_text(_x + 40, _y + i * spacing, item.name);
    draw_text(_x + 40, _y + i * spacing + 20, "Level " + string(item.level));
	
	// If item has experience, draw exp bar
    if (item.type = "weapon") {
        var bar_x = _x + 20;
        var bar_y = item_y + 45;
        var bar_width = 80;
        var bar_height = 10;
        var exp_ratio = item.xp / item.max_xp;

        // Background bar
        draw_set_color(c_dkgray);
        draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

        // Filled portion
        draw_set_color(c_lime);
        draw_rectangle(bar_x, bar_y, bar_x + (bar_width * exp_ratio), bar_y + bar_height, false);

        // Label
        //draw_set_color(c_white);
        //draw_text(bar_x + bar_width + 5, bar_y, string(item.exp) + "/" + string(item.exp_max));
    }
	
}

/*
draw_set_alpha(0.5);
draw_set_color(c_white);
draw_rectangle(_x - 10, _y - 10, _x + 126, _y + spacing * array_length(gear_list), false);
draw_set_alpha(1);
*/