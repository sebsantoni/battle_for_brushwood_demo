class_name CardPile
extends Resource

signal card_pile_size_changed

@export var cards: Array[Card]
@export var label_right: bool


func add_card(card: Card) -> void:
	cards.append(card)
	cards.shuffle()


func add_cards(card_arr: Array[Card]) -> void:
	cards += card_arr
	cards.shuffle()


func delete_card(card: Card) -> void:
	cards.erase(card)


func draw_cards(num_cards: int) -> Array[Card]:
	if size() < num_cards:
		return []
	
	cards.shuffle()
	var cards_: Array[Card] = []
	
	while num_cards > 0:
		cards_.append(cards.pop_back())
		num_cards -= 1
	
	return cards_


func size() -> int:
	return cards.size()


func shuffle() -> void:
	cards.shuffle()
