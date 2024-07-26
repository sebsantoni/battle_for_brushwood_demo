class_name ImaginationContainer
extends HBoxContainer

@export var imagination_pool: CardPile

var num_imagined_cards: int = 3

const Card_Handler_Scene = preload("res://scenes/card/card_handler.tscn")


func _ready() -> void:
	Events.imagination_started.connect(_on_imagination_started)
	Events.imagination_ended.connect(_on_imagination_ended)


func _on_imagination_started(pool: CardPile) -> void:
	imagination_pool = pool
	self.visible = true
	
	var cards = generate_cards(num_imagined_cards)
	instantiate_cards(cards)


func _on_imagination_ended() -> void:
	var card = get_chosen_card()
	Events.add_to_hand_requested.emit(card)
	self.visible = false
	self.reset()


func generate_cards(num_cards: int) -> Array:
	var cards = []
	
	if imagination_pool.size() < num_cards:
		return cards
	
	imagination_pool.shuffle()
	
	for i in range(num_cards):
		cards.append(imagination_pool.cards[i])
	
	return cards


func instantiate_cards(cards: Array) -> void:
	for card in cards:
		var card_handler = Card_Handler_Scene.instantiate()
		card_handler.init(CardUI.new(), CardStateMachine.new(),card)
		card_handler.imagined = true
		
		self.add_child(card_handler)
		
		card_handler.card_ui.scale *= 1.5


func get_chosen_card() -> Card:
	for handler: CardHandler in self.get_children():
		if handler.chosen:
			return handler.card
	
	return null


func reset() -> void:
	imagination_pool = null
	var children: Array = self.get_children().duplicate()
	
	for child: CardHandler in children:
		child.queue_free()
		self.remove_child(child)
