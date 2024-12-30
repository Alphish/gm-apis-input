function ApisInputState(_scheme, _identifier) constructor {
    scheme = _scheme;
    identifier = _identifier;
    
    static update = function() {
        throw ApisInputException.method_not_implemented(self, nameof(update));
    }
    
    static clear = function() {
        throw ApisInputException.method_not_implemented(self, nameof(clear));
    }
    
    static chain = function() {
        return self;
    }
}
