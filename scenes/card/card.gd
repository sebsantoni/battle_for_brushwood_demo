class_name Card
extends Control

@onready var card_ui = $CardUI
@onready var card_state_machine: CardStateMachine = $CardStateMachine


func _ready() -> void:
	card_state_machine.init(card_ui)


func _input(event: InputEvent) -> void:
	card_state_machine._on_input(event)


func _on_gui_input(event):
	card_state_machine._on_gui_input(event)


func _on_mouse_entered():
	card_state_machine._on_mouse_entered()


func _on_mouse_exited():
	card_state_machine._on_mouse_exited()



#class_name Card
#extends Resource
#
#enum Type {Attack, Spell, Aura, Character}
#
#@export_group("Gameplay Attributes")
#var type: Type
#var cost: int
#
#@export_group("Visual Attributes")
#var art: TextureRect
#var name_: String
#var description: String
#
#
#func play() -> void:
	## called when the card is played
	#pass
