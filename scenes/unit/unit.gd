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

func prepare(allies, enemies) -> void:
	species.move_handler.prepare(self, allies, enemies)

func move() -> void:
	species.move_handler.execute(self)


func take_damage(amount: int) -> void:
	print(self, " took ", amount, " damage!")
	if amount >= hp:
		print(self, "died!")
		self.queue_free()
	else:
		hp -= amount
		print(self, " has ", hp, " hp remaining!")
	
	stat_bar.update_health_label(hp)

func init_stats() -> void:
	hp = species.max_hp


func update_ui() -> void:
	stat_bar.update_health_label(hp)
	stat_bar.update_block_label(block)
