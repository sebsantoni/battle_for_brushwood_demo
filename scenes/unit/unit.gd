class_name Unit
extends Node

@onready var hitbox = $Hitbox
@onready var intent_ui = $IntentUI
@onready var intent_handler = $IntentHandler
@onready var stat_bar = $StatBar
@onready var status_handler: StatusHandler = $StatusHandler

@export var species: Species

var hp: int
var block: int = 0


func _ready() -> void:
	intent_handler.init(self)
	init_stats()
	update_ui()
	status_handler.status_owner = self
	species.move_handler.init()
	self.texture = species.sprite


func prepare(allies, enemies) -> void:
	species.move_handler.prepare(self, allies, enemies)
	var current_move = species.move_handler.current_move
	
	var damaging_effects = [
		Move.EffectType.Damage,
		Move.EffectType.Damage_Boosted,
		Move.EffectType.Damage_Debuff]
	
	if status_handler.has_status("Charmed"):
		while current_move.EffectType in damaging_effects:
			species.move_handler.prepare(self, allies, enemies)
			current_move = species.move_handler.current_move


func move() -> void:
	species.move_handler.execute(self)


func take_damage(amount: int) -> void:
	if amount >= hp:
		Events.unit_died.emit(self)
		for child in self.get_children():
			child.queue_free()
		self.queue_free()
	else:
		hp -= amount
	
	update_ui()


func gain_block(amount: int) -> void:
	self.block += amount
	update_ui()


func heal(amount: int) -> void:
	self.health = clampi(hp + amount, hp + amount, species.max_hp)
	update_ui()


func init_stats() -> void:
	hp = species.max_hp


func update_ui() -> void:
	stat_bar.update_health_label(hp)
	stat_bar.update_block_label(block)
	stat_bar.update_drowsy_label(status_handler.get_status_stacks("Drowsy"))
	stat_bar.update_asleep_label(status_handler.get_status_stacks("Asleep"))
	stat_bar.update_strength_label(status_handler.get_status_stacks("Strength"))
