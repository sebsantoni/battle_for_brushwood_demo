class_name CardScene
extends Control

@onready var card_ui = $CardUI
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@export var card: CardResource


func _ready() -> void:
	card_state_machine.init(card_ui)


func load_ui() -> void:
	card_ui.card = card
	card_ui.load_ui()


func _input(event: InputEvent) -> void:
	card_state_machine._on_input(event)


func _on_gui_input(event):
	card_state_machine._on_gui_input(event)


func _on_mouse_entered():
	card_state_machine._on_mouse_entered()


func _on_mouse_exited():
	card_state_machine._on_mouse_exited()


func play(dropped, target) -> void:
	card.play(dropped, target)
