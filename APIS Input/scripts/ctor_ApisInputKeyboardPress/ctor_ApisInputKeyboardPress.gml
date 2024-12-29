function ApisInputKeyboardPress(_key, _modifiers = undefined, _groupid = undefined, _priority = 0) : ApisInputPress(_groupid, _priority) constructor {
    key = to_keycode(_key);
    modifiers = _modifiers ?? no_modifiers;
    array_map_ext(modifiers, to_keycode);
    
    if (is_undefined(_groupid)) {
        group_id = $"KEYPRESS:{key}";
        priority = array_length(modifiers);
    }
    
    static no_modifiers = [];
    
    static to_keycode = function(_key) {
        return is_string(_key) ? ord(_key) : _key;
    }
    
    static check_down = function() {
        return keyboard_check(key) && array_all(modifiers, keyboard_check);
    }
    
    static check_pressed = function() {
        return keyboard_check_pressed(key) && array_all(modifiers, keyboard_check);
    }
}
