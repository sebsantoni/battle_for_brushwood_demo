class_name CardHandler
extends Control

@onready var card_ui = $CardUI
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@export var card: Card

var disabled = false

signal return_to_hand(card_handler: CardHandler)
signal card_played(card_handler: CardHandler)


func init(card_ui_: CardUI, state_machine: CardStateMachine, card_: Card) -> void:
	if not card_ui:
		card_ui = card_ui_
	
	if not card_state_machine:
		card_state_machine = state_machine
	
	if not card:
		card = card_
	
	if not card_state_machine.is_node_ready():
		await ready
		
	card_state_machine.init(self)
	
	if not card_ui.is_node_ready():
		await ready
	
	card_ui.card = card
	card_ui.card_handler = self
		
	card_ui.load_ui()


func _input(event: InputEvent) -> void:
	if not disabled:
		card_state_machine._on_input(event)


func _on_gui_input(event):
	if not disabled:
		card_state_machine._on_gui_input(event)


func _on_mouse_entered():
	if not disabled:
		card_state_machine._on_mouse_entered()


func _on_mouse_exited():
	if not disabled:
		card_state_machine._on_mouse_exited()


func play(player: Player, dropped: bool, target: Unit) -> bool:
	'''Returns whether the card was successfully played'''
	var success: bool = card.play(player, dropped, target)
	
	return success


func disable() -> void:
	disabled = true


func enable() -> void:
	disabled = false

