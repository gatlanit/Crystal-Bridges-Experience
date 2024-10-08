extends XROrigin3D

# Do all controller specific things here
signal bButton
signal yButton

signal thumbVecL(name: String, value: Vector2)
signal thumbVecR(name: String, value: Vector2)

# Left buttons (click)
func _on_left_hand_button_pressed(name: String) -> void:
	if name == "by_button":
		yButton.emit()

# Right buttons (click)
func _on_right_hand_button_pressed(name: String) -> void:
	if name == "by_button":
		bButton.emit()

# Left buttons (Vector2)
func _on_left_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	thumbVecL.emit(name, value)

# Right buttons (Vector2)
func _on_right_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	thumbVecR.emit(name, value)
