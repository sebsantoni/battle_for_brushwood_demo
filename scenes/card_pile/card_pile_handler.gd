class_name CardPileHandler
extends Control

@export var card_pile: CardPile
@export var card_pile_icon: Texture

@onready var card_pile_ui = $CardPileUI
@onready var card_pile_view = $CardPileView


func _ready() -> void:
	card_pile.card_pile_size_changed.connect(_on_card_pile_size_changed)
	
	card_pile_ui.card_pile = card_pile
	card_pile_ui.card_pile_handler = self
	card_pile_ui.load_ui()


func _on_card_pile_size_changed() -> void:
	card_pile_ui.update_count()


func add_to_pile(cards: Array[Card]) -> void:
	card_pile.add_cards(cards)
	card_pile.card_pile_size_changed.emit()


func draw_from_pile(num_cards: int) -> Array[Card]:
	var cards = card_pile.draw_cards(num_cards)
	card_pile.card_pile_size_changed.emit()
	return cards
