/// @description Setup

if (instance_number(sys_ApisInput) > 1)
    throw ApisInputException.instance_duplicate();

if (is_callable(scheme)) {
    var _is_constructor = script_exists(scheme) && asset_has_tags(scheme, ["@@constructor"], asset_script);
    scheme = _is_constructor ? new scheme() : scheme();
}

if (!is_instanceof(scheme, ApisInputScheme))
    throw ApisInputException.invalid_scheme();

scheme.init();
scheme.reconfigure();
