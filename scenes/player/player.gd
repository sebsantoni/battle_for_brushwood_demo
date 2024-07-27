class_name Player
extends Sprite2D

signal mana_changed

@export_group("Battle Attributes")
@export var hero: Hero
var hp: int
var mana: int
var block: int = 0

@export_group("Non-Battle Attributes")
@export var gold: int

@onready var stat_bar: StatBar = $StatBar
@onready var status_handler: StatusHandler = $StatusHandler
@onready var hitbox = $Hitbox


func _ready() -> void:
	init_stats()
	update_ui()
	status_handler.status_owner = self
	status_handler.stats_changed.connect(_on_stats_changed)


func play(card_handler: CardHandler, dropped: bool, target, is_enemy: bool) -> void:
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
		success = card_handler.play(self, dropped, target, is_enemy)
	
	if success:
		self.mana -= card_handler.card.cost
		mana_changed.emit()
		card_handler.card_played.emit(card_handler)
	else:
		card_handler.return_to_hand.emit(card_handler)


func init_stats() -> void:
	hp = hero.max_hp
	mana = hero.max_mana
	

func update_ui() -> void:
	stat_bar.update_health_label(hp)
	stat_bar.update_block_label(block)
	stat_bar.update_drowsy_label(status_handler.get_status_stacks("Drowsy"))
	stat_bar.update_asleep_label(status_handler.get_status_stacks("Asleep"))
	stat_bar.update_strength_label(status_handler.get_status_stacks("Strength"))
	stat_bar.update_burned_label(status_handler.get_status_stacks("Burned"))
	stat_bar.update_charmed_label(status_handler.get_status_stacks("Charmed"))
	stat_bar.update_defence_label(status_handler.get_status_stacks("Defence"))
	

func take_damage(amount: int) -> void:
	if amount >= hp + block:
		Events.player_died.emit(self)
		self.queue_free()
	elif block >= amount:
			pass
	else:
		hp -= amount - block
	
	update_ui()


func gain_block(amount: int) -> void:
	self.block += amount
	update_ui()


func heal(amount: int) -> void:
	self.hp = clampi(hp + amount, hp + amount, hero.max_hp)
	update_ui()


func set_mana(amount: int) -> void:
	self.mana = amount


func _on_stats_changed() -> void:
	update_ui()
