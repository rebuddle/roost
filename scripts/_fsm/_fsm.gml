// state constructor
function state(_start, _step, _stop) constructor {
    start = _start != undefined ? _start : function() {};
    step  = _step  != undefined ? _step  : function() {};
    stop  = _stop  != undefined ? _stop  : function() {};
}

// feeds into the finite state machine
function FSM(_initialState) {
    return {
        state: _initialState,
        states: {},

        add_state: function(_name, _state_obj) {
            self.states[$ _name] = _state_obj;
        },

        change_state: function(_new) {
            var current = self.states[$ self.state];
            if (current != undefined && current.stop != undefined) {
                current.stop();
            }

            self.state = _new;

            var next = self.states[$ self.state];
            if (next != undefined && next.start != undefined) {
                next.start();
            }
        },

        step: function() {
            var current = self.states[$ self.state];
            if (current != undefined && current.step != undefined) {
                current.step();
            }
        },

        stop: function() {
            var current = self.states[$ self.state];
            if (current != undefined && current.stop != undefined) {
                current.stop();
            }
        }
    };
}
