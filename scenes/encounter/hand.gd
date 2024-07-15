class_name Hand
extends HBoxContainer

var card_handlers: Array[CardHandler]
var cards: Array[Card]


func _ready() -> void:
	
	for handler: CardHandler in self.get_children():
		handler.card_played.connect(_on_card_played)
		card_handlers.append(handler)
		
	cards = get_cards_from_handlers(card_handlers)


func add_to_hand(from: CardPileHandler, num_cards: int) -> void:
	var cards_ = from.draw_from_pile(num_cards)
	
	for card in cards_:
		var card_handler = CardHandler.new()
		card_handler.card = card
		self.add_child(card_handler)
		card_handlers.append(card_handler)
		cards.append(card)


func remove_from_hand(to: CardPileHandler, handlers: Array[CardHandler]) -> void:
	var cards_ = get_cards_from_handlers(handlers)
	
	for handler in handlers:
		card_handlers.erase(handler)
		cards.erase(handler.card)
		self.remove_child(handler)
		handler.queue_free()
	
	to.add_to_pile(cards_)


func enable() -> void:
	for handler in card_handlers:
		handler.enable()


func disable() -> void:
	for handler in card_handlers:
		handler.disable()


func get_cards_from_handlers(handlers: Array[CardHandler]) -> Array[Card]:
	var cards_: Array[Card] = []
	for handler in handlers:
		cards_.append(handler.card)
	return cards_


func _on_card_played(handler: CardHandler) -> void:
	self.remove_child(handler)
	handler.queue_free()
