class_name Player
extends Sprite2D

@export_group("Battle Attributes")
@export var hero: Hero
var hp: int
var mana: int
var block: int = 0

@export_group("Non-Battle Attributes")
@export var gold: int


func _ready() -> void:
	init_stats()


func play(card_handler: CardHandler, dropped: bool, enemy: Unit) -> void:
	'''
	Plays the given card on the given targets (if any...)
	WHO should be responsible for the logic of determining targets, etc...?
	the card itself I guess? just pass along the info from encounter...
	'''
	# this class (Player) is responsible for playing the card only if it's
	# possible to do so...depending on any restrictions
	# for now, assume the only restriction is mana (no effects which limit
	# number of playable cards per turn, etc., all of which can probably
	# modify the Hero anyway...)
	var success = false
	if card_handler.card.cost <= self.mana:
		success = card_handler.play(self, dropped, enemy)
	
	if success:
		self.mana -= card_handler.card.cost
	else:
		card_handler.return_to_hand.emit(card_handler)


func init_stats() -> void:
	hp = hero.max_hp
	mana = hero.max_mana


func take_damage(amount: int) -> void:
	print(self, " took ", amount, " damage!")
	if amount >= hp:
		print(self, "died!")
		self.queue_free()
	else:
		hp -= amount
		print(self, " has ", hp, " hp remaining!")


'''
Player HAS a hero, since this hero is chosen by the player
In addition, they have temporary stats rather than max ones:
	hp
	block
	mana
	any statuses/buffs/debuffs
	gold
	etc.

Player is also responsible for the play() function which allows
them to play a card! very important for a card game :3

I'm finding it hard to differentiate between the player in battle, and
the overall player playing the game... but I guess they can be made into one
for now? Can be refactored later
'''
