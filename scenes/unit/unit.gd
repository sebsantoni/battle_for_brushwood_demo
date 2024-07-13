class_name Unit
extends Node

@onready var hitbox = $Hitbox
@onready var intent_ui = $IntentUI
@onready var intent_handler = $IntentHandler

@export var species: Species
var hp: int
var block: int = 0

var allies: Array
var enemies: Array


func _ready() -> void:
	intent_handler.init(self)
	init_stats()


func prepare() -> void:
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


func init_stats() -> void:
	hp = species.max_hp
