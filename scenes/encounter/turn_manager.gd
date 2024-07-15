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
	
	draw_cards()
	
	player.set_mana(player.hero.max_mana)
	
	character_handler.declare_intents()
	enemy_handler.declare_intents()
	
	hand.enable()
	end_turn_button.disabled = false


func end_turn() -> void:
	end_turn_button.disabled = true
	
	discard_hand()
	
	character_handler.activate_turn_end_statuses()
	enemy_handler.activate_turn_end_statuses()
	
	character_handler.trigger_moves()
	enemy_handler.trigger_moves()
	
	# these will be sent to whatever class(es) deal(s) with 
	# battle win/loss conditions in the future! Maybe we just emit
	# the signals here?
	
	if not player:
		print("battle lost!")
		return
	
	if enemy_handler.is_empty():
		print("battle won!")
		return
		
	start_turn()


func draw_cards() -> void:
	var num_cards = player.hero.cards_per_turn
	
	if num_cards > draw_pile.size():
		draw_pile.add_to_pile(discard_pile.draw_from_pile(discard_pile.size()))
	
	hand.add_to_hand(draw_pile, num_cards)
	hand.disable()


func discard_hand() -> void:
	hand.disable()
	hand.remove_from_hand(discard_pile, hand.card_handlers)
