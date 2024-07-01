extends CardStateNode


func _on_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		transition_requested.emit(self, CardState.Idle)
	
	if event is InputEventMouseMotion:
		card.global_position = card.get_global_mouse_position() - card.size/2
	
	if event.is_action_released("left_click"):
		transition_requested.emit(self, CardState.Released)
