// probably unecessary but could be helpful to have indicators
enum gear {
	lhand,
	rhand,
	helm,
	armor,
	boots
}
enum stat {
	hp,
	mana,
	attack,
	dexterity,
	defence,
	vitality,
	wisdom,
	move_speed
}

// player manager: levels, stats, and gear
player_manager = {
	// level
	level: 1,
	experience: 0,
	experience_to_next: 100,
	
	// resource stats
	max_hp: 12,
	hp: 12,
	max_mana: 100,
	mana: 100,
	
	// base stats
	attack: 5,
	dexterity: 5,
	defence: 5,
	vitality: 5,
	wisdom: 5,
	move_speed: 5,
	
	// gear
	lhand: noone,
	rhand: noone,
	helm: noone,
	armor: noone,
	boots: noone,
	
	// equip gear: slot - lhand, rhand, etc
	equip: function(slot, item_name) {
		switch(slot) 
		{
			// weapons
			case gear.lhand:
				self.lhand = global.weapon_list[$ item_name];
				break;
			case gear.rhand:
				self.rhand = global.weapon_list[$ item_name];
				break;
				
			// armor
			case gear.helm:
				break;
			case gear.armor:
				break;
			case gear.boots:
				break;
		}
	},
	
	
	// attack lhand
	lhand_cooldown: 0,
	rhand_cooldown: 0,
	dash_cooldown: 0,
	
	step_cooldowns: function() {
		// update cooldown
		if lhand_cooldown > 0 {
			lhand_cooldown--;
		}
		if rhand_cooldown > 0 {
			rhand_cooldown--;	
		}
		if dash_cooldown > 0 {
			dash_cooldown--;
		}
	},
	
	set_cooldown: function(cooldown, amount) {
		// set cooldown
		switch(cooldown){
			case gear.lhand:
				self.lhand_cooldown = amount;
				break;
			case gear.rhand:
				self.rhand_cooldown = amount;
				break;
		}
	},
	
	use_attack: function(hand, _x, _y, _depth){
		// init vars
		var weapon = noone;
		var weapon_cooldown;
		
		// pick attack
		switch(hand){
			case gear.lhand:
				weapon = self.lhand;
				weapon_cooldown = self.lhand_cooldown;
				break;
			case gear.rhand:
				weapon = self.rhand;
				weapon_cooldown = self.rhand_cooldown;
				break;
		}
		
		// exit if noone
		if (!weapon) {
			return;
		}
		
		// create slash
		if (weapon_cooldown <= 0) {
			var slash = instance_create_depth(_x, _y, _depth, weapon.slash_object);
			// update slash properties
			slash.alarm[0] = weapon.range;
			slash.sprite_index = weapon.slash_sprite;
			slash.damage = (weapon.base_damage + self.attack);
			slash.spd = self.move_speed;
			
			// add cooldown of attack
			weapon_cooldown = 300/(weapon.attack_speed + self.dexterity);
			self.set_cooldown(hand, weapon_cooldown);
		}
		
		
		
	}
	
}

// equip an iron dagger!
player_manager.equip(gear.lhand, "sword");
player_manager.equip(gear.rhand, "bow");

// player states: idle, move, dash
// IDLE
idle_state = new state(
    function() { // start
        sprite = [spr_player_box, spr_player_box, spr_player_box, spr_player_box];
    },
    function() { // step
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
		lattkey = mouse_check_button(mb_left);
		rattkey = mouse_check_button(mb_right);
		
		// trigger attack
		if (lattkey) {
			player_manager.use_attack(gear.lhand, x, y, depth+1);
		}
		if (rattkey) {
			player_manager.use_attack(gear.rhand, x, y, depth+1);
		}
		
		// trigger movement
        if (abs(horz) > 0 || abs(vert) > 0) {
            fsm.change_state("move");
        }
    }
);

// MOVE
move_state = new state(
    function() { 
		player_manager.move_speed = 8; 
	},
    function() {
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * player_manager.move_speed;
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * player_manager.move_speed;
		dkey = keyboard_check(vk_space);
		lattkey = mouse_check_button(mb_left);
		rattkey = mouse_check_button(mb_right);
		
		// trigger attack
		if (lattkey) {
			player_manager.use_attack(gear.lhand, x, y, depth+1);
		}
		if (rattkey) {
			player_manager.use_attack(gear.rhand, x, y, depth+1);
		}
		
		// trigger dash state
		if (!player_manager.dash_cooldown && dkey) && (abs(horz) > 0 || abs(vert) > 0) {
			fsm.change_state("dash");
			return;
		}

		// move back to idle state
        if (abs(horz) == 0 && abs(vert) == 0) {
            fsm.change_state("idle");
			return;
        }

        _script_movement(horz, vert, player_manager.move_speed);
    }
);

// DASH
dash_state = new state(
	function() {
		player_manager.dash_cooldown = 30;
		dash_dur = player_manager.move_speed * 1.5;
		player_manager.move_speed = 16;
	},
	function() {
		// dash
		_script_movement(horz, vert, player_manager.move_speed);
		
		// trail effect
		with (instance_create_depth(x, y, depth+1, obj_player_dash_trail)){
			sprite_index = other.sprite_index;
			//image_blend = c_silver;
			image_blend = c_fuchsia;
			image_alpha = 0.7;
		}
			
		// hold dash state until duration is out
		dash_dur = max(dash_dur-1, 0);
		if dash_dur == 0 {
			fsm.change_state("idle");
		}	
	}
);


// init FSM
fsm = FSM(undefined);

// add states
fsm.add_state("idle", idle_state);
fsm.add_state("move", move_state);
fsm.add_state("dash", dash_state);

fsm.change_state("idle");
