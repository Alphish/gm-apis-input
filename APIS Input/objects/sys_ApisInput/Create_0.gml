/// @description Setup

if (instance_number(sys_ApisInput) > 1)
    throw ApisInputException.instance_duplicate();

if (!is_callable(system_constructor))
    throw ApisInputException.invalid_system_constructor();

var _is_constructor = script_exists(system_constructor) && asset_has_tags(system_constructor, ["@@constructor"], asset_script);
system = _is_constructor ? new system_constructor() : system_constructor();

if (!is_instanceof(system, ApisInputSystem))
    throw ApisInputException.invalid_system_constructor();

system.init();
system.reconfigure();
