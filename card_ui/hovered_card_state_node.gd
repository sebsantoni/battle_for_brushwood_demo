extends CardStateNode


func enter() -> void:
	card.position.y -= 10


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		transition_requested.emit(self, CardState.Selected)


func _on_mouse_exited() -> void:
	card.position.y += 10
	transition_requested.emit(self, CardState.Idle)
