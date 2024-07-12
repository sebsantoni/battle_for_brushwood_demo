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

@onready var enemy_handler = $EnemyHandler
@onready var ally_handler = $AllyHandler

@onready var card_drop_area = $CardDropArea
@onready var player = $AllyHandler/Player
@onready var hand = $EncounterUI/Hand

var enemies: Array = []
var allies: Array = []

func _ready() -> void:
	Events.card_released.connect(_on_card_released)
	
	for enemy: Unit in enemy_handler.get_children():
		enemies.append(enemy)
	
	for ally in ally_handler.get_children():
		allies.append(ally)
	
	for enemy: Unit in enemy_handler.get_children():
		enemy.allies = enemies
		enemy.enemies = allies
		enemy.species.move_handler.init()
	
	for ally in ally_handler.get_children():
		if ally is Unit:
			ally.allies = allies
			ally.enemies = enemies
			ally.species.move_handler.init()
	
	for card_handler: CardHandler in hand.get_children():
		card_handler.return_to_hand.connect(_on_return_to_hand)
	
	for enemy: Unit in enemy_handler.get_children():
		enemy.move()

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
		if card_ui.card_area in enemy.hitbox.get_overlapping_areas():
			target = enemy
	
	return target


func _on_return_to_hand(card_handler: CardHandler) -> void:
	card_handler.card_ui.position = Vector2(0,0)
	
