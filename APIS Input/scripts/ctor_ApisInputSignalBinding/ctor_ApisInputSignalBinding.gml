function ApisInputSignalBinding(_identifier, _signal) constructor {
    identifier = _identifier;
    bound_signal = _signal;
    
    static update = function() {
        throw ApisInputException.method_not_implemented(self, nameof(update));
    }
    
    static clear = function() {
        throw ApisInputException.method_not_implemented(self, nameof(clear));
    }
}
