extends Node3D

@onready var stream = $AudioStreamPlayer3D
@onready var model = $Museum

var move_speed: float = 1.5 # Speed of movement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_passthrough()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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

# Buttons

# Thumbstick
func _on_player_thumb_vec_l(_name: String, value: Vector2) -> void:
	var rotateAmt = value.x * move_speed * get_process_delta_time()
	model.rotate_y(-rotateAmt)

func _on_player_thumb_vec_r(_name: String, value: Vector2) -> void:
	# How much to move based on y component of vector, speed, and delta
	var upDownAmt = value.y * move_speed * get_process_delta_time()
	
	# Create new y value
	var new_y = model.global_transform.origin.y + upDownAmt 
	
	# Y value between 0 and 1 (no modulo because x/0 = undefined)
	new_y = clamp(new_y, 0.0, 1.0)
	
	# Update model y position with y value
	var new_transform = model.global_transform
	new_transform.origin.y = new_y
	model.global_transform = new_transform


func _on_player_b_button() -> void:
	if !stream.playing:
		stream.play()

func _on_player_y_button() -> void:
	if stream.playing:
		stream.stop()
