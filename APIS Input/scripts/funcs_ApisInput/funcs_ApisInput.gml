function apis_input_get_instance() {
    if (!instance_exists(sys_ApisInput))
        throw ApisInputException.instance_not_found();
    
    return sys_ApisInput.id;
}

function apis_input_get_system() {
    return apis_input_get_instance().system;
}

function apis_input_get_binding(_identifier, _type = undefined) {
    var _binding = apis_input_get_system().find_binding(_identifier);
    if (!is_undefined(_type) && (!is_struct(_binding) || !is_instanceof(_binding, _type)))
        throw ApisInputException.unexpected_type("binding", _identifier, _type, _binding);
    
    return _binding;
}

function apis_input_get_mode(_identifier, _type = undefined) {
    var _mode = apis_input_get_system().find_mode(_identifier);
    if (!is_undefined(_type) && (!is_struct(_mode) || !is_instanceof(_mode, _type)))
        throw ApisInputException.unexpected_type("mode", _identifier, _type, _mode);
    
    return _mode;
}

function apis_input_get_state(_modeid, _stateid, _type = undefined) {
    var _mode = apis_input_get_mode(_modeid);
    var _state = !is_undefined(_mode) ? _mode.find_state(_stateid) : undefined;
    if (!is_undefined(_type) && (!is_struct(_state) || !is_instanceof(_state, _type)))
        throw ApisInputException.unexpected_type("state", _modeid + "." + _stateid, _type, _state);
    
    return _state;
}

