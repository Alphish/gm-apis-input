function ApisInputPressBinding(_identifier, _signal) : ApisInputSignalBinding(_identifier, _signal) constructor {
    is_pressed = false;
    is_down = false;
    is_released = false;
    
    static update = function() {
        if (!is_down) {
            is_pressed = bound_signal.check_pressed();
            is_down = is_pressed;
            is_released = false;
        } else {
            is_pressed = false;
            is_down = bound_signal.check_down();
            is_released = !is_down;
        }
        return is_down;
    }
    
    static clear = function() {
        is_pressed = false;
        is_down = false;
        is_released = false;
    }
}
