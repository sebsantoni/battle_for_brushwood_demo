class_name Card
extends Control

@onready var card_ui = $CardUI
@onready var card_state_machine: CardStateMachine = $CardStateMachine

enum CardType {Attack, Spell, Aura, Character}
enum TargetType {Self, All_Enemies, Everyone, Enemy}

@export var card_type: CardType
@export var cost: int
@export var targeted: bool
@export var target_type: TargetType



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


func play(dropped: bool, target: Enemy) -> void:
	if targeted:
		if not target:
			return
		else:
			print("card played on target: ", target)
	else:
		if target or not dropped:
			return
		else:
			print("non-targeted card played")
		
	
	
