class_name Card
extends Resource

enum CardType {Attack, Spell, Aura, Character}
enum TargetType {Self, All_Enemies, Everyone, Enemy, Anyone}
enum Rarity {Common, Uncommon, Rare}

@export_group("Gameplay Attributes")
@export var card_type: CardType
@export var cost: int
@export var targeted: bool
@export var target_type: TargetType
@export var exhaustable: bool = false

@export_group("Visual Attributes")
@export var rarity: Rarity
@export var art: Texture
@export var name: String
@export_multiline var description: String

@export_group("Character Attributes")
@export var species: Species


func play(_player: Player, _dropped: bool, _target, is_enemy: bool) -> bool:
	'''Returns whether this card was successfully played'''
	return true


func update_description(_player: Player) -> void:
	pass
