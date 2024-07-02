extends CardStateNode


func enter() -> void:
	if not card_ui.is_node_ready():
		await ready 
	
	card_ui.return_to_hand.emit(card_ui)


func _on_mouse_entered() -> void:
	transition_requested.emit(self, CardState.Hovered)
