extends CardStateNode


func enter() -> void:
	if not card.is_node_ready():
		await ready 


func _on_mouse_entered() -> void:
	print("hovered")
	transition_requested.emit(self, "Hovered")
