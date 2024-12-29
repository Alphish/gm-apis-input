function ApisInputSystem() constructor {
    bindings_by_id = {};
    
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
    
    static define_binding_keyboard_press = function(_identifier, _key, _modifiers = undefined, _groupid = undefined, _priority = 0) {
        var _signal = new ApisInputKeyboardPress(_key, _modifiers, _groupid, _priority);
        var _binding = new ApisInputPressBinding(_identifier, _signal);
        return register_binding(_binding);
    }
}
