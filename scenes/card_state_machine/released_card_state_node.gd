extends CardStateNode

func enter() -> void:
	Events.card_released.emit(card_ui)


func _on_mouse_exited() -> void:
	transition_requested.emit(self, CardState.Idle)
