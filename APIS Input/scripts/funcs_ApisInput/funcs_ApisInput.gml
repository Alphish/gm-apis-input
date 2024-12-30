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

function apis_input_get_scheme(_identifier, _type = undefined) {
    var _scheme = apis_input_get_system().find_scheme(_identifier);
    if (!is_undefined(_type) && (!is_struct(_scheme) || !is_instanceof(_scheme, _type)))
        throw ApisInputException.unexpected_type("scheme", _identifier, _type, _scheme);
    
    return _scheme;
}

function apis_input_get_state(_schemeid, _stateid, _type = undefined) {
    var _scheme = apis_input_get_scheme(_schemeid);
    var _state = !is_undefined(_scheme) ? _scheme.find_state(_stateid) : undefined;
    if (!is_undefined(_type) && (!is_struct(_state) || !is_instanceof(_state, _type)))
        throw ApisInputException.unexpected_type("state", _schemeid + "." + _stateid, _type, _state);
    
    return _state;
}

