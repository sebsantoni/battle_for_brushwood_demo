class_name CardStateNode
extends Node

signal transition_requested(from: CardStateNode, to: CardState)

enum CardState {Idle, Hovered, Selected, Released}
@export var state: CardState

var card_handler: CardHandler
var card_ui: CardUI


func enter() -> void:
	pass


func exit() -> void:
	pass 


func _on_input(_event: InputEvent) -> void:
	pass


func _on_gui_input(_event: InputEvent) -> void:
	pass


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	pass
