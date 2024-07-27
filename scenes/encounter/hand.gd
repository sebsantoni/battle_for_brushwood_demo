class_name Hand
extends Control

@export var player: Player

var card_handlers: Array[CardHandler]
var cards: Array[Card]

@onready var discard_pile: CardPileHandler = $"../../DeckUI/DiscardPile"
@onready var exhaust_pile: CardPileHandler = $"../../DeckUI/ExhaustPile"

const Card_Handler_Scene = preload("res://scenes/card/card_handler.tscn")

@export var width_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve

var max_hand_size = 10


func _ready() -> void:
	
	for handler: CardHandler in self.get_children():
		handler.card_played.connect(_on_card_played)
		handler.return_to_hand.connect(_on_return_to_hand)
		card_handlers.append(handler)
		
	cards = get_cards_from_handlers(card_handlers)
	
	Events.add_to_hand_requested.connect(_on_add_to_hand_requested)
	
	player.status_handler.stats_changed.connect(update_descriptions)


func add_cards_from_pile(from: CardPileHandler, num_cards: int) -> void:
	var cards_ = from.draw_from_pile(num_cards)
	for card in cards_:
		add_to_hand(card)

	arrange_hand()


func remove_from_hand(to: CardPileHandler, handlers: Array[CardHandler]) -> void:
	var cards_ = get_cards_from_handlers(handlers)
	var handlers_ = handlers.duplicate()
	for i in range(handlers.size()):
		var handler = handlers_[i]
		card_handlers.erase(handler)
		cards.erase(handler.card)
		handler.queue_free()
		self.remove_child(handler)
	
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
	var handler_index = handler.get_index()
	card_handlers.erase(handler)
	cards.erase(handler.card)
	
	if not handler.card.exhaustable:
		discard_pile.add_to_pile([handler.card])
	else:
		exhaust_pile.add_to_pile([handler.card])
	
	handler.queue_free()
	remove_index(handler_index)
	arrange_hand()


func _on_return_to_hand(card_handler: CardHandler) -> void:
	card_handler.card_ui.position = Vector2(0,0)
	arrange_hand()


func arrange_hand() -> void:
	var num_cards = self.get_child_count()
	
	self.size.x = num_cards * 15
	self.position.x = (get_viewport_rect().size.x - self.size.x)/2
	
	for handler in card_handlers:
		handler.position = Vector2((self.size.x - handler.size.x)/2, 0)

		var ratio = 0.5
		
		if num_cards > 1:
			ratio = float(handler.get_index()) / float(num_cards - 1)
			
			if ratio < 0.5:
				handler.pivot_offset = Vector2(handler.size.x, 0)
			
			handler.position.x += width_curve.sample(ratio) * self.size.x / 2
			handler.position.y -= height_curve.sample(ratio) * 5
			handler.rotation = rotation_curve.sample(ratio) * -0.3


func remove_index(index: int) -> void:
	for child in self.get_children():
		if child.get_index() > index:
			self.move_child(child, child.get_index() - 1)


func add_to_hand(card: Card) -> void:
	var card_handler = Card_Handler_Scene.instantiate()
	card_handler.init(CardUI.new(), CardStateMachine.new(),card)
	card_handlers.append(card_handler)
	cards.append(card)
	
	card_handler.card_played.connect(_on_card_played)
	card_handler.return_to_hand.connect(_on_return_to_hand)
	
	self.add_child(card_handler)


func _on_add_to_hand_requested(card: Card) -> void:
	add_to_hand(card)
	arrange_hand()


func update_descriptions() -> void:
	print("updating descriptions...")
	for handler in card_handlers:
		handler.card.update_description(player)
		handler.card_ui.update_description()
