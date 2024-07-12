class_name Unit
extends Node

@onready var hitbox = $Hitbox
@export var species: Species

var hp: int
var block: int

var allies: Array
var enemies: Array


func prepare() -> void:
	species.move_handler.prepare(self, allies, enemies)

func move() -> void:
	species.move_handler.execute(self)
