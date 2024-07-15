class_name CardStateMachine
extends Node

@export var starting_node: CardStateNode

var current_node: CardStateNode
var states: Dictionary = {} # maps a CardState to the CardStateNode that handles it
func init(card_handler: CardHandler) -> void:
	for child in self.get_children():
		if child is CardStateNode:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_handler = card_handler
			child.card_ui = card_handler.card_ui

	if starting_node:
		starting_node.enter()
		current_node = starting_node


func _on_input(event: InputEvent) -> void:
	if current_node:
		current_node._on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	if current_node:
		current_node._on_gui_input(event)


func _on_mouse_entered() -> void:
	if current_node:
		current_node._on_mouse_entered()


func _on_mouse_exited() -> void:
	if current_node:
		current_node._on_mouse_exited()


func _on_transition_requested(from: CardStateNode, to: CardStateNode.CardState) -> void:
	if not from or from != current_node or from.state not in states or to not in states:
		return
	
	var new_node = states[to]
	
	current_node.exit()
	new_node.enter()
	
	
	current_node = new_node
