extends CardStateNode


func enter() -> void:
	if not card_ui.is_node_ready():
		await ready 


func _on_mouse_entered() -> void:
	transition_requested.emit(self, CardState.Hovered)
