class_name TurnManager
extends Control

var character_handler: UnitHandler
var enemy_handler: UnitHandler

var player: Player

@export var end_turn_button: Button

var hand: Hand

var draw_pile: CardPileHandler
var discard_pile: CardPileHandler

var battle_result_label


func _ready() -> void:
	end_turn_button.pressed.connect(end_turn)
	Events.player_died.connect(_on_player_died)


func start_turn() -> void:
	if player:
		player.status_handler.activate_turn_start()
		player.set_mana(player.hero.max_mana)
		
	character_handler.activate_turn_start_statuses()
	enemy_handler.activate_turn_start_statuses()
	
	draw_cards()
	
	character_handler.declare_intents()
	enemy_handler.declare_intents()
	
	if not player.status_handler.has_status("Asleep"):
		hand.enable()
		
	end_turn_button.disabled = false
	
	if not player:
		end_turn_button.disabled = true
		battle_result_label.text = "Battle Lost!"
		battle_result_label.visible = true
		return
	
	if enemy_handler.is_empty():
		battle_result_label.text = "Battle Won!"
		battle_result_label.visible = true
		end_turn_button.disabled = true
		return


func end_turn() -> void:
	end_turn_button.disabled = true
	
	discard_hand()
	
	if player:
		player.status_handler.activate_turn_end()
		
	character_handler.activate_turn_end_statuses()
	enemy_handler.activate_turn_end_statuses()
	
	character_handler.trigger_moves()
	enemy_handler.trigger_moves()
	
	if not player:
		battle_result_label.text = "Battle Lost!"
		battle_result_label.visible = true
		return
	
	if enemy_handler.is_empty():
		battle_result_label.text = "Battle Won!"
		battle_result_label.visible = true
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


func _on_player_died(_player) -> void:
	player = null
