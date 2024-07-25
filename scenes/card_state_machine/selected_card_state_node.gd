extends CardStateNode


func enter() -> void:
	if card_handler.imagined:
		card_handler.chosen = true
		Events.imagination_ended.emit()
		transition_requested.emit(self, CardState.Idle)
	

func _on_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		transition_requested.emit(self, CardState.Idle)
	
	if event is InputEventMouseMotion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.size/2
	
	if event.is_action_released("left_click"):
		transition_requested.emit(self, CardState.Released)
