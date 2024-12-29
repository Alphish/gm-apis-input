function ApisInputPress(_groupid = undefined, _priority = 0) : ApisInputSignal(_groupid, _priority) constructor {
    static check_pressed = function() {
        throw ApisInputException.method_not_implemented(self, nameof(check_pressed));
    }
    
    static check_down = function() {
        throw ApisInputException.method_not_implemented(self, nameof(check_down));
    }
}
