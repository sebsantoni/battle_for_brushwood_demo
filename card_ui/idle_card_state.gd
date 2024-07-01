extends CardStateNode


func enter() -> void:
	if not card.is_node_ready():
		await ready 
	
	card.return_to_hand.emit(card)


func _on_mouse_entered() -> void:
	transition_requested.emit(self, CardState.Hovered)
