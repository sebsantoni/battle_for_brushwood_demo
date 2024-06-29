#meta-name: Card
#meta-description: Create a new card
class_name Card
extends Node

enum Type {Attack, Spell, Aura, Character}

@export_group("Gameplay Attributes")
var type: Type
var cost: int

@export_group("Visual Attributes")
var art: TextureRect
var name_: String
var description: String


func play() -> void:
	# called when the card is played
	pass
