class_name CardStateNode
extends Node

signal transition_requested(from: CardStateNode, to: CardStateNode)

enum CardState {Idle, Hovered, Clicked, Dragged, Released}
@export var state: CardState

var card: CardTest


func enter() -> void:
	pass


func exit() -> void:
	pass 


func _on_input(event: InputEvent) -> void:
	pass


func _on_gui_input(event: InputEvent) -> void:
	pass


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	pass
