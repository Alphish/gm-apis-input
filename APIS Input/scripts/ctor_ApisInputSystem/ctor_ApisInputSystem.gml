function ApisInputSystem() constructor {
    bindings_by_id = {};
    
    modes = [];
    modes_by_id = {};
    current_mode = undefined;
    
    static init = function() {
        if (static_get(self) == static_get(ApisInputSystem)) {
            throw ApisInputException.custom_system_required();
        } else {
            throw ApisInputException.method_not_implemented(self, nameof(init));
        }
    }
    
    static reconfigure = function() {
        array_foreach(modes, function(_mode) { _mode.reconfigure(); });
    }
    
    // ----------
    // Processing
    // ----------
    
    static process = function() {
        current_mode.process();
    }
    
    // --------
    // Bindings
    // --------
    
    static register_binding = function(_binding) {
        var _key = string_lower(_binding.identifier);
        if (struct_exists(bindings_by_id, _binding))
            throw ApisInputException.binding_duplicate(_binding.identifier);
        
        bindings_by_id[$ _key] = _binding;
        return _binding;
    }
    
    static find_binding = function(_identifier) {
        var _key = string_lower(_identifier);
        return bindings_by_id[$ _key];
    }
    
    static define_binding_blank_press = function(_identifier) {
        var _binding = new ApisInputPressBinding(_identifier, undefined);
        return register_binding(_binding);
    }
    
    static define_binding_keyboard_press = function(_identifier, _key, _modifiers = undefined, _groupid = undefined, _priority = undefined) {
        var _signal = new ApisInputKeyboardPress(_key, _modifiers, _groupid, _priority);
        var _binding = new ApisInputPressBinding(_identifier, _signal);
        return register_binding(_binding);
    }
    
    // -----
    // Modes
    // -----
    
    static register_mode = function(_mode) {
        var _key = string_lower(_mode.identifier);
        if (struct_exists(modes_by_id, _mode))
            throw ApisInputException.mode_duplicate(_mode.identifier);
        
        array_push(modes, _mode);
        modes_by_id[$ _key] = _mode;
        return _mode;
    }
    
    static find_mode = function(_identifier) {
        var _key = string_lower(_identifier);
        return modes_by_id[$ _key];
    }
    
    static define_mode = function(_identifier, _constructor = ApisInputMode) {
        var _mode = new _constructor(_identifier);
        return register_mode(_mode);
    }
    
    static switch_mode = function(_mode) {
        if (is_string(_mode))
            _mode = modes_by_id[$ _mode];
        
        if (_mode == current_mode)
            return;
        
        current_mode.clear();
        current_mode = _mode;
    }
}
