function ApisInputException(_code, _description) constructor {
    code = _code;
    description = _description;
}

// -------------------
// Creating exceptions
// -------------------

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
