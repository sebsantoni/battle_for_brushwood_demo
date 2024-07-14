class_name TurnManager
extends Control

# should we just get Encounter as the reference?
# turns can only be played in an encounter!

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

func _ready() -> void:
	start_turn()


func start_turn() -> void:
	# Stage 1: Start of Turn actions
	# activate Turn_Start Statuses in AllyHandler
	# activate Turn_Start Statuses in EnemyHandler
	# draw and disable the player's cards
	# refill the player's mana
	# prepare units in AllyHandler
	# prepare units in EnemyHandler
	
	# Stage 2: Player regains control
	# Enable cards in the player's hand
	# Enable EndTurnButton
	pass


func end_turn() -> void:
	# Disable EndTurnButton
	# Disable all cards in the player's hand
	# Discard all cards in the player's hand
	# Activate Turn_End Statuses in AllyHandler
	# Activate Turn_End Statuses in EnemyHandler
	# execute moves in AllyHandler
	# execute moves in EnemyHandler
	# start_turn() iff EnemyHandler and AllyHandler are not empty
	# (if EnemyHandler empty, win!, if AllyHandler empty, lose!)
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
