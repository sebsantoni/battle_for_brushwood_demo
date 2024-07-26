class_name Unit
extends Node

@onready var hitbox: Area2D = $Hitbox
@onready var intent_ui: IntentUI = $IntentUI
@onready var intent_handler: IntentHandler = $IntentHandler
@onready var stat_bar: StatBar = $StatBar
@onready var status_handler: StatusHandler = $StatusHandler

@export var species: Species

var hp: int
var block: int = 0


func init(
	hitbox_: Area2D = null, intent_ui_: IntentUI = null, 
	intent_handler_: IntentHandler = null, stat_bar_: StatBar = null,
	stat_handler: StatusHandler = null, species_: Species = null
) -> void:
	
	if not hitbox:
		hitbox = hitbox_
	
	if not intent_ui:
		intent_ui = intent_ui_
	
	if not intent_handler:
		intent_handler = intent_handler_
	
	if not stat_bar:
		stat_bar = stat_bar_
	
	if not status_handler:
		status_handler = stat_handler
	
	if species_:
		species = species_
	
	if not intent_handler.is_node_ready():
		await ready 
		
	intent_handler.init(self)
	
	if not status_handler.is_node_ready():
		await ready
	
	status_handler.status_owner = self
	
	self.texture = species.sprite
	species.move_handler.init()
	
	init_stats()
	update_ui()


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
	self.hp = clampi(hp + amount, hp + amount, species.max_hp)
	update_ui()


func init_stats() -> void:
	hp = species.max_hp


func update_ui() -> void:
	stat_bar.update_health_label(hp)
	stat_bar.update_block_label(block)
	stat_bar.update_drowsy_label(status_handler.get_status_stacks("Drowsy"))
	stat_bar.update_asleep_label(status_handler.get_status_stacks("Asleep"))
	stat_bar.update_strength_label(status_handler.get_status_stacks("Strength"))
