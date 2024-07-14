class_name CardPileHandler
extends Control

@export var card_pile: CardPile
@export var card_pile_icon: Texture

@onready var card_pile_ui = $CardPileUI
@onready var card_pile_view = $CardPileView


func _ready() -> void:
	card_pile_ui.card_pile = card_pile
	card_pile_ui.card_pile_handler = self
	card_pile_ui.load_ui()
