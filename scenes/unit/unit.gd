class_name Unit
extends Node

@onready var hitbox = $Hitbox
@onready var intent_ui = $IntentUI
@onready var intent_handler = $IntentHandler

@export var species: Species
var hp: int
var block: int

var allies: Array
var enemies: Array


func _ready() -> void:
	intent_handler.unit = self
	intent_handler.move_handler = species.move_handler
	intent_handler.intent_ui = intent_ui

func prepare() -> void:
	species.move_handler.prepare(self, allies, enemies)

func move() -> void:
	species.move_handler.execute(self)
