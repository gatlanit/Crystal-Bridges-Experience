extends XROrigin3D

@onready var streamX = $AudioStreamPlayerX
@onready var streamY = $AudioStreamPlayerY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_hand_button_pressed(name: String) -> void:
	if name == "ax_button":
		if !streamX.playing:
			streamX.play()
	if name == "by_button":
		if !streamY.playing:
			streamY.play()
