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
