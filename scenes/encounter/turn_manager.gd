class_name TurnManager
extends Control

# should we just get Encounter as the reference?
# turns can only be played in an encounter!

var character_handler: UnitHandler
var enemy_handler: UnitHandler

var player: Player

var end_turn_button: Button


func _ready() -> void:
	end_turn_button.pressed.connect(end_turn)
	
	start_turn()


func start_turn() -> void:
	# Stage 1: Start of Turn actions
	character_handler.activate_turn_start_statuses()
	enemy_handler.activate_turn_start_statuses()
	
	# disable and draw the player's cards
	# --
	
	# refill the player's mana
	player.set_mana(player.hero.max_mana)
	
	character_handler.declare_intents()
	enemy_handler.declare_intents()
	
	# Stage 2: Player regains control
	# Enable cards in the player's hand
	# --
	
	end_turn_button.disabled = false


func end_turn() -> void:
	# Disable EndTurnButton
	end_turn_button.disabled = true
	
	# disable and discard the player's hand
	# --
	
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

'''
Start of Turn:
	Triggered by: Entering the scene for the first time or End of Turn finishing
	Ends by: All actions being completed in this function
	Player has control: No
	Actions:
		Activate Turn_Start Statuses
		Player draws cards
		Disable all cards in hand
		Player refills mana
		Units prepare moves
		Move onto player actions
		
	
Player Actions:
	Triggered by: All actions completed in Start of Turn
	Player has control: Yes
	Actions:
		Enable cards in the player's hand
		Enable EndTurnButton
		
	
End of Turn:
	Triggered by: Player hits End of Turn button
	Player has control: No
	Actions:
		Disable EndTurnButton
		Disable all cards in the player's hand (set_process(false))
		Discard all cards in the player's hand
		Activate Turn_End Statuses
		Characters execute moves
		Enemies execute moves
		Call Start_of_Turn if battle not won (check later)
		
'''

# need references to:
# ally_handler
# enemy_handler
# player?
# hand
# draw_pile
# discard_pile
# endturnbutton
# -- 
# should these be created as a new class? or share a common script
# for handling units within them... then we can have player separately
# --
