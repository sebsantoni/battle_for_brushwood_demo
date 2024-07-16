class_name Encounter
extends Node2D

'''
Responsible for handling the Encounter scene during a battle. 
When a card is released, the encounter scene should process
the information in the scene and send it over to the Card class
to process what happened. 

The Encounter scene knows the card drop area, the units in the scene, 
and the hand/cards being played.
'''
@onready var player: Player = $Player

@onready var enemy_handler: UnitHandler = $EnemyHandler
@onready var character_handler: UnitHandler = $CharacterHandler

@onready var turn_manager: TurnManager = $TurnManager

@onready var card_drop_area = $CardDropArea
@onready var hand: Hand = $EncounterUI/Hand

@onready var draw_pile = $EncounterUI/DrawPile
@onready var discard_pile = $EncounterUI/DiscardPile

@onready var mana_icon: ManaIcon = $EncounterUI/ManaIcon
@onready var end_turn_button = $EndTurnButton

@onready var intent_arrow_drawer: IntentArrowDrawer = $IntentArrows/IntentArrowDrawer

@onready var battle_result_label = $BattleResultLabel

var enemies: Array = []
var allies: Array = []


func _ready() -> void:
	Events.card_released.connect(_on_card_released)
	Events.unit_hovered.connect(_on_unit_hovered)
	Events.unit_unhovered.connect(_on_unit_unhovered)
	
	init_unit_handlers()
	init_turn_manager()
	
	turn_manager.start_turn()
	
	draw_pile.init(preload("res://heroes/writer/warrior_starting_deck.tres"))
	discard_pile.init(preload("res://card_piles/discard_pile.tres"))

func init_unit_handlers() -> void:
	allies = character_handler.get_children() + [player]
	enemies = enemy_handler.get_children()
	
	character_handler.allies = allies
	character_handler.enemies = enemies
	
	enemy_handler.allies = enemies
	enemy_handler.enemies = allies


func init_turn_manager() -> void:
	turn_manager.character_handler = character_handler
	turn_manager.enemy_handler = enemy_handler
	turn_manager.player = player
	turn_manager.hand = hand
	turn_manager.draw_pile = draw_pile
	turn_manager.discard_pile = discard_pile
	turn_manager.battle_result_label = battle_result_label


func _on_card_released(card_ui: CardUI) -> void:
	# we want to know what the targets of the card are and pass that over
	# the card itself should handle the logic
	# the encounter is only responsible for passing on the info of the battle
	# what info is needed?: 
	# is the card in the drop area?
	# was the card released on a unit (enemy/hero/character?)
	
	# should enemies always be in the drop area? for now, not necessarily...
	# we simply gather if in drop area and if on a unit
	# if unit, pass on the unit as well
	
	# how are units gonna work? is that a class itself? 
	# let's stick to enemies for now
	
	var in_drop_area = card_in_drop_area(card_ui)
	var enemy = targeted_enemy(card_ui) # can be expanded to unit instead of enemy
	
	# we will be passing it onto the player, actually!
	player.play(card_ui.card_handler, in_drop_area, enemy)


func card_in_drop_area(card_ui: CardUI) -> bool:
	for area in card_drop_area.get_overlapping_areas():
		if area == card_ui.card_area:
			return true
	
	return false


func targeted_enemy(card_ui) -> Unit:
	# assume the card is played on a single enemy for now...
	# returns the enemy targeted by the card on release.
	# if no enemy is targeted, returns null
	var target: Unit = null
	
	for enemy in enemies:
		if enemy != null:
			if card_ui.card_area in enemy.hitbox.get_overlapping_areas():
				target = enemy
	
	return target


func _on_unit_hovered(unit: Unit) -> void:
	intent_arrow_drawer.draw_target_lines(unit)


func _on_unit_unhovered() -> void:
	intent_arrow_drawer.hide_target_lines()

