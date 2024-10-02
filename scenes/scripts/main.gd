extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_passthrough()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Passthrough
func enable_passthrough() -> bool:
	var xr_interface: XRInterface = XRServer.primary_interface
	if xr_interface and xr_interface.is_passthrough_supported():
		if !xr_interface.start_passthrough():
			return false
	else:
		var modes = xr_interface.get_supported_environment_blend_modes()
		if xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
			xr_interface.set_environment_blend_mode(xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND)
		else:
			return false
	
	get_viewport().transparent_bg = true
	return true
