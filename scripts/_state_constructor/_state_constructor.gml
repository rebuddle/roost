// finite state machine constructor
function state() constructor {
	start = function() {};
	step = function() {};
	stop = function() {};
}

/*
// init state
function state_init(_state) {
	_current_state = _state;
	_current_state.start();
}

// run state function
function state_step() {
	_current_state.step();
}

// transition to another state
function state_change(_state) {
	_current_state.stop();
	_cuttent_state = _state;
	_current_state.start();
}
*/