class_name TurnManager
extends Control

var character_handler: UnitHandler
var enemy_handler: UnitHandler

var player: Player

@export var end_turn_button: Button

var hand: Hand

var draw_pile: CardPileHandler
var discard_pile: CardPileHandler


func _ready() -> void:
	end_turn_button.pressed.connect(end_turn)


func start_turn() -> void:
	character_handler.activate_turn_start_statuses()
	enemy_handler.activate_turn_start_statuses()
	
	hand.add_to_hand(draw_pile, player.hero.cards_per_turn)
	hand.disable()
	
	player.set_mana(player.hero.max_mana)
	
	character_handler.declare_intents()
	enemy_handler.declare_intents()
	
	hand.enable()
	end_turn_button.disabled = false


func end_turn() -> void:
	end_turn_button.disabled = true
	
	hand.disable()
	hand.remove_from_hand(discard_pile, hand.card_handlers)
	
	character_handler.activate_turn_end_statuses()
	enemy_handler.activate_turn_end_statuses()
	
	character_handler.trigger_moves()
	enemy_handler.trigger_moves()
	
	if not player:
		print("battle lost!")
		return
	
	if enemy_handler.is_empty():
		print("battle won!")
		return
		
	start_turn()
