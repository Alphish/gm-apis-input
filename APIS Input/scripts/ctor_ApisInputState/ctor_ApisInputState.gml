function ApisInputState(_mode, _identifier) constructor {
    mode = _mode;
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
