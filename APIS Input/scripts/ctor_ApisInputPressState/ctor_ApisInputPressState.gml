function ApisInputPressState(_scheme, _identifier) : ApisInputState(_scheme, _identifier) constructor {
    bindings = [];
    current_binding = undefined;
    
    is_pressed = false;
    is_down = false;
    is_released = false;
    
    // ----------
    // Processing
    // ----------
    
    static update = function() {
        current_binding = resolve_current_binding();
        if (is_undefined(current_binding))
            return;
        
        is_pressed = current_binding.is_pressed;
        is_down = current_binding.is_down;
        is_released = current_binding.is_released;
    }
    
    static resolve_current_binding = function() {
        var _index = array_find_index(bindings, function(_binding) { return _binding.is_pressed; });
        return _index >= 0 ? bindings[_index] : current_binding;
    }
    
    // -------------
    // Configuration
    // -------------
    
    static add_binding = function(_binding) {
        array_push(bindings, _binding);
        scheme.register_binding(_binding);
    }
    
    static bind_to = function(_identifier) {
        var _binding = apis_input_get_binding(_identifier);
        add_binding(_binding);
    }
    
    static bind_keyboard_press = function(_identifier, _key, _modifiers = undefined, _groupid = undefined, _priority = undefined) {
        var _binding = apis_input_get_system().define_binding_keyboard_press(_identifier, _key, _modifiers, _groupid, _priority);
        add_binding(_binding);
    }
    
    static bound_to = function(_identifier) {
        return chain(bind_to(_identifier));
    }
    
    static bound_to_keyboard_press = function(_identifier, _key, _modifiers = undefined, _groupid = undefined, _priority = undefined) {
        return chain(bind_keyboard_press(_identifier, _key, _modifiers, _groupid, _priority));
    }
}
