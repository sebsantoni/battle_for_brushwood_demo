class_name CardStateMachine
extends Node

@export var starting_node: CardStateNode

var current_node: CardStateNode
var nodes: Dictionary = {} # maps CardStateNodes to CardStates


func init(card: CardTest) -> void:
	for child in self.get_children():
		if child is CardStateNode:
			nodes[child] = child.state
			child.transition_requested.connect(_on_transition_requested)
			child.card = card

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


func _on_transition_requested(from: CardStateNode, to: CardStateNode) -> void:
	if not from or from != current_node or from.state not in nodes or to.state not in nodes:
		return
	
	var new_node = nodes[to]
	current_node.exit()
	new_node.enter()
