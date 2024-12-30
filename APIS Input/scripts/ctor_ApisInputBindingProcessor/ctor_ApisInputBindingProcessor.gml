function ApisInputBindingProcessor(_bindings) constructor {
    var _resolved_bindings = resolve_bindings(_bindings);
    
    standalone_bindings = _resolved_bindings.standalone_bindings;
    binding_groups = _resolved_bindings.binding_groups;
    
    // ---------
    // Resolving
    // ---------
    
    static resolve_bindings = function(_bindings) {
        static result = { standalone_bindings: [], binding_groups: [] };
        
        result.standalone_bindings = [];
        result.binding_groups = [];
        
        // preliminary sorting of bindings into groups
        var _groups_by_id = {};
        for (var i = 0, _count = array_length(_bindings); i < _count; i++) {
            var _binding = _bindings[i];
            var _signal = _binding.bound_signal;
            if (is_undefined(_signal)) {
                _binding.clear();
                continue;
            }
            
            var _group_id = _signal.group_id;
            if (is_undefined(_group_id) || _group_id == "") {
                array_push(result.standalone_bindings, _binding);
                continue;
            }
            
            if (!struct_exists(_groups_by_id, _group_id))
                _groups_by_id[$ _group_id] = [];
            
            array_push(_groups_by_id[$ _group_id], _binding);
        }
        
        // sorting groups into standalone bindings and priority-sorted lists
        var _keys = struct_get_names(_groups_by_id);
        for (var i = 0, _count = array_length(_keys); i < _count; i++) {
            var _group = _groups_by_id[$ _keys[i]];
            if (array_length(_group) == 1) {
                // single-element groups are treated as standalone bindings
                // because there's no previous binding that can hide the next binding
                array_push(result.standalone_bindings, _group[0]);
            } else {
                // multi-element groups are sorted according to priority
                // with higher-priority active bindings "hiding" the later ones
                array_sort(_group, function(_left, _right) { return _right.bound_signal.priority - _left.bound_signal.priority; });
                array_push(result.binding_groups, _group);
            }
        }
        
        return result;
    }
    
    // ----------
    // Processing
    // ----------
    
    static update = function() {
        array_foreach(standalone_bindings, function(_binding) { _binding.update(); });
        
        array_foreach(binding_groups, function(_group) {
            var _active_found = false;
            for (var i = 0, _count = array_length(_group); i < _count; i++) {
                var _binding = _group[i];
                if (!_active_found) {
                    _active_found = _binding.update();
                } else {
                    _binding.clear();
                }
            }
        });
    }
    
    static clear = function() {
        array_foreach(standalone_bindings, function(_binding) { _binding.clear(); });
        
        array_foreach(binding_groups, function(_group) {
            array_foreach(_group, function(_binding) { _binding.clear(); });
        });
    }
}
