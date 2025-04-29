// variables
dash_cd = 0;

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
	lhand_attack: function(_x, _y, _depth){
		if (!self.lhand) {
			return;
		}
		
		// update cooldown
		if lhand_cooldown > 0 {
			lhand_cooldown--;
		}
		
		// create slash
		if (lhand_cooldown <= 0) {
			var slash = instance_create_depth(_x, _y, _depth, obj_slash);
			// update slash properties
			slash.alarm[0] = self.lhand.range;
			slash.sprite_index = self.lhand.slash_sprite;
			slash.damage = (self.lhand.base_damage + self.attack);
			slash.spd = self.move_speed;
			
			// add cooldown of attack
			self.lhand_cooldown = 300/(self.lhand.attack_speed + self.dexterity);
		}
	},
	
	// attack rhand
	rhand_cooldown: 0,
	rhand_attack: function(_x, _y, _depth){
		if (!self.rhand) {
			return;
		}
		
		// update cooldown
		if rhand_cooldown > 0 {
			rhand_cooldown--;
		}
		
		// create slash
		if (rhand_cooldown <= 0) {
			var slash = instance_create_depth(_x, _y, _depth, obj_slash);
			// update slash properties
			slash.alarm[0] = self.rhand.range;
			slash.sprite_index = self.rhand.slash_sprite;
			slash.damage = (self.rhand.base_damage + self.attack);
			slash.spd = self.move_speed;
			
			// add cooldown of attack
			self.rhand_cooldown = 300/(self.rhand.attack_speed + self.dexterity);
		}
	}
	
}

// equip an iron dagger!
player_manager.equip(gear.lhand, "iron_dagger");
player_manager.equip(gear.rhand, "iron_sword");

// player states: idle, move, dash
// IDLE
idle_state = new state(
    function() { // start
        sprite = [spr_player_box, spr_player_box, spr_player_box, spr_player_box];
    },
    function() { // step
        horz = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
        vert = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
		akey = mouse_check_button(mb_left);
		
		// trigger attack
		if (akey) {
			player_manager.lhand_attack(x, y, depth+1);
		}
		
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
		akey = mouse_check_button(mb_left);
		
		// trigger attack
		if (akey) {
			player_manager.lhand_attack(x, y, depth+1);
		}
		
		// trigger dash state
		if (!dash_cd && dkey) && (abs(horz) > 0 || abs(vert) > 0) {
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
		dash_cd = 30;
		dash_dur = 12;
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
