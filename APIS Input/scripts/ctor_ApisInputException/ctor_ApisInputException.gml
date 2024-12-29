function ApisInputException(_code, _description) constructor {
    code = _code;
    description = _description;
}

// -------------------
// Creating exceptions
// -------------------

ApisInputException.instance_duplicate = function() {
    return new ApisInputException(
        $"apis_input_instance_duplicate",
        $"Cannot create another APIS Input system instance. Only one APIS Input system instance can exist at once."
        );
}

ApisInputException.invalid_system_constructor = function() {
    return new ApisInputException(
        $"apis_input_invalid_system_constructor",
        $"The 'system_constructor' variable of APIS Input system must be a constructor inheriting from ApisInputSystem or a function returning an instance of such a constructor."
        );
}

ApisInputException.custom_system_required = function() {
    return new ApisInputException(
        $"apis_input_custom_system_required",
        $"Cannot create an instance of {nameof(ApisInputSystem)} directly. A custom input system must be created instead.\n" +
        $"The custom input system must inherit from ApisInputSystem constructor and implement the init() method.\n" +
        $"Once the custom input system is made, set the 'system_constructor' variable of APIS Input system instance to its constructor."
        );
}

ApisInputException.method_not_implemented = function(_caller, _method) {
    return new ApisInputException(
        $"apis_input_not_implemented",
        $"{instanceof(_caller)}.{_method} is not implemented."
        );
}

ApisInputException.binding_duplicate = function(_identifier) {
    return new ApisInputException(
        $"apis_input_binding_duplicate",
        $"Cannot define another input binding with '{_identifier}' identifier. The input system already defines a scheme with this identifier."
        );
}
