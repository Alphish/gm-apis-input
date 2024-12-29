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
