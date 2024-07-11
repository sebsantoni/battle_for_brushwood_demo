class_name Unit
extends Node

@onready var hitbox = $Hitbox
@export var species: Species

var hp: int
var block: int

var allies: Array[Unit]
var enemies: Array[Unit]


func move() -> void:
	species.move_handler.execute(self, allies, enemies)
