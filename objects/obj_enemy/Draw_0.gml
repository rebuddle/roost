// In the Draw Event
// Calculate the healthbar percentage
var health_percentage = (hp / max_hp) * 100;

draw_self();
// Draw the healthbar
draw_healthbar(	x - 5, y + 10, x + 5, y + 12//x - 25, y - 20, x + 25, y - 10
				,health_percentage, c_black, c_red, c_green
				, 0, true, false);