class_name CardUI
extends Control

signal return_to_hand(card: CardUI)

@onready var card_state_machine: CardStateMachine = $CardStateMachine


func _ready() -> void:
	card_state_machine.init(self)


func _input(event: InputEvent) -> void:
	card_state_machine._on_input(event)


func _on_gui_input(event):
	card_state_machine._on_gui_input(event)


func _on_mouse_entered():
	card_state_machine._on_mouse_entered()


func _on_mouse_exited():
	card_state_machine._on_mouse_exited()
