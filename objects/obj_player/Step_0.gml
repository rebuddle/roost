// cooldowns
dash_cd = max(dash_cd -1, 0);

// execute the current state on the state machine
script_execute(_current_state);