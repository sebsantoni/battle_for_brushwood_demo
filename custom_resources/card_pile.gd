class_name CardPile
extends Resource

@export var cards: Array[Resource]
@export var label_right: bool


func add_card(card: Card) -> void:
	cards.append(card)


func delete_card(card: Card) -> void:
	cards.erase(card)


func size() -> int:
	return cards.size()
