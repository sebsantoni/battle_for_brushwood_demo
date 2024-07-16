class_name Hand
extends HBoxContainer

var card_handlers: Array[CardHandler]
var cards: Array[Card]
@onready var discard_pile: CardPileHandler = $"../DiscardPile"

const Card_Handler_Scene = preload("res://scenes/card/card_handler.tscn")


func _ready() -> void:
	
	for handler: CardHandler in self.get_children():
		handler.card_played.connect(_on_card_played)
		handler.return_to_hand.connect(_on_return_to_hand)
		card_handlers.append(handler)
		
	cards = get_cards_from_handlers(card_handlers)


func add_to_hand(from: CardPileHandler, num_cards: int) -> void:
	var cards_ = from.draw_from_pile(num_cards)
	for card in cards_:
		var card_handler = Card_Handler_Scene.instantiate()
		card_handler.init(CardUI.new(), CardStateMachine.new(),card)
		card_handlers.append(card_handler)
		cards.append(card)
		
		card_handler.card_played.connect(_on_card_played)
		card_handler.return_to_hand.connect(_on_return_to_hand)
		
		self.add_child(card_handler)


func remove_from_hand(to: CardPileHandler, handlers: Array[CardHandler]) -> void:
	var cards_ = get_cards_from_handlers(handlers)
	var handlers_ = handlers.duplicate()
	for i in range(handlers.size()):
		var handler = handlers_[i]
		card_handlers.erase(handler)
		cards.erase(handler.card)
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
	card_handlers.erase(handler)
	cards.erase(handler.card)
	discard_pile.add_to_pile([handler.card])
	handler.queue_free()


func _on_return_to_hand(card_handler: CardHandler) -> void:
	card_handler.card_ui.position = Vector2(0,0)
