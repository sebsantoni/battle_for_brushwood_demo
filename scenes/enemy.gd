class_name Enemy
extends Sprite2D

@onready var hitbox: Area2D = $Hitbox

enum CardType {Attack, Spell, Aura, Character}
enum TargetType {Self, All_Enemies, Everyone, Enemy}

@export var card_type: CardType
@export var cost: int
@export var targeted: bool
@export var target_type: TargetType

