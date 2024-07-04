class_name CardResource
extends Resource

enum CardType {Attack, Spell, Aura, Character}
enum TargetType {Self, All_Enemies, Everyone, Enemy}
enum Rarity {Common, Uncommon, Rare}

@export_group("Gameplay Attributes")
@export var card_type: CardType
@export var cost: int
@export var targeted: bool
@export var target_type: TargetType

@export_group("Visual Attributes")
@export var rarity: Rarity
@export var art: Texture
@export var name: String
@export var description: String


func play(_dropped: bool, _target: Enemy) -> void:
	pass
