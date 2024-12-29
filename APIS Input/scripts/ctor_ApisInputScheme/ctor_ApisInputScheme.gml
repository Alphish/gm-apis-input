function ApisInputScheme(_identifier) constructor {
    identifier = _identifier;
    
    bindings = [];
    bindings_by_id = {};
    binding_processor = undefined;
    
    states = [];
    states_by_id = {};
    
    static reconfigure = function() {
        binding_processor = new ApisInputBindingProcessor(bindings);
    }
    
    // ----------
    // Processing
    // ----------
    
    static process = function() {
        binding_processor.update();
        
        array_foreach(states, function(_state) { _state.update(); });
    }
    
    // -----------
    // Definitions
    // -----------
    
    static register_binding = function(_binding) {
        var _key = string_lower(_binding.identifier);
        if (struct_exists(bindings_by_id, _key))
            return; // the binding is reused between press states, for whatever reason
        
        array_push(bindings, _binding);
        bindings_by_id[$ _key] = _binding;
        return _binding;
    }
    
    static register_state = function(_state) {
        var _key = string_lower(_state.identifier);
        if (struct_exists(states_by_id, _key))
            throw ApisInputException.state_duplicate(self, _state.identifier);
        
        array_push(states, _state);
        states_by_id[$ _key] = _state;
        return _state;
    }
    
    static define_press_state = function(_identifier) {
        var _state = new ApisInputPressState(self, _identifier);
        return register_state(_state);
    }
}
