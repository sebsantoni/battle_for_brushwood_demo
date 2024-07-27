class_name CardPileHandler
extends Control

@export var card_pile: CardPile
@export var card_pile_icon: Texture

@onready var card_pile_ui = $CardPileUI
@onready var card_pile_view = $CardPileView


func init(card_pile_: CardPile) -> void:
	card_pile = card_pile_
	card_pile.card_pile_size_changed.connect(_on_card_pile_size_changed)
	
	if not card_pile_ui.is_node_ready():
		await ready
		
	card_pile_ui.card_pile = card_pile
	card_pile_ui.card_pile_handler = self
	card_pile_ui.load_ui()
	
	if not card_pile_view.is_node_ready():
		await ready
	
	card_pile_view.card_pile = card_pile
	card_pile_view.instantiate_card_handlers()
	

func _on_card_pile_size_changed() -> void:
	card_pile_ui.update_count()
	card_pile_view.update_card_handlers()


func add_to_pile(cards: Array[Card]) -> void:
	card_pile.add_cards(cards)
	card_pile.card_pile_size_changed.emit()


func draw_from_pile(num_cards: int) -> Array[Card]:
	var cards = card_pile.draw_cards(num_cards)
	card_pile.card_pile_size_changed.emit()
	return cards


func size() -> int:
	return card_pile.size()


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		card_pile_view.show()


func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
		card_pile_view.hide()
