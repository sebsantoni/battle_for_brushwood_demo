class_name CardHandler
extends Control

@onready var card_ui = $CardUI
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@export var card: Card

signal return_to_hand(card_handler: CardHandler)
signal card_played(card_handler: CardHandler)


func _ready() -> void:
	card_state_machine.init(self)
	card_ui.card = card
	card_ui.card_handler = self
	card_ui.load_ui()


func _input(event: InputEvent) -> void:
	card_state_machine._on_input(event)


func _on_gui_input(event):
	card_state_machine._on_gui_input(event)


func _on_mouse_entered():
	card_state_machine._on_mouse_entered()


func _on_mouse_exited():
	card_state_machine._on_mouse_exited()


func play(player: Player, dropped: bool, target: Unit) -> bool:
	'''Returns whether the card was successfully played'''
	var success: bool = card.play(player, dropped, target)
	
	if not success:
		return_to_hand.emit(self)
	else:
		self.queue_free()
	
	return success


func disable() -> void:
	card_ui.collision_area.set_deferred("disabled", true)


func enable() -> void:
	card_ui.collision_area.set_deferred("disabled", false)

