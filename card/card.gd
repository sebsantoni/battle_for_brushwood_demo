#meta-name: Card
#meta-description: Create a new card
class_name Card
extends Resource

enum Type {Attack, Spell, Aura, Character}

@export_group("Gameplay Attributes")
var type: Type
var cost

@export_group("Visual Attributes")
var art: TextureRect
var name_
var description


func play():
	# called when the card is played
	pass

