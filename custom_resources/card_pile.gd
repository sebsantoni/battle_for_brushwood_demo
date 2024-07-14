class_name CardPile
extends Resource

signal card_pile_size_changed

@export var cards: Array[Resource]
@export var label_right: bool


func add_card(card: Card) -> void:
	cards.append(card)
	card_pile_size_changed.emit()


func delete_card(card: Card) -> void:
	cards.erase(card)
	card_pile_size_changed.emit()


func size() -> int:
	return cards.size()
