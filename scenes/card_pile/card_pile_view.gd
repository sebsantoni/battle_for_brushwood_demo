class_name CardPileView
extends PanelContainer

var card_pile: CardPile

const Card_Handler_Scene = preload("res://scenes/card/card_handler.tscn")

@onready var card_container = $MarginContainer/ScrollContainer/MarginContainer/CardContainer


func _ready() -> void:
	self.global_position = (get_viewport_rect().size - self.size) / 2


func instantiate_card_handlers() -> void:
	for card in card_pile.cards:
		if card:
			instantiate_card_handler(card)


func instantiate_card_handler(card: Card) -> void:
	var card_handler = Card_Handler_Scene.instantiate()
	card_handler.init(CardUI.new(), CardStateMachine.new(),card)
	card_handler.disable()
	card_container.add_child(card_handler)


func update_card_handlers() -> void:
	clear_card_handlers()
	instantiate_card_handlers()


func clear_card_handlers() -> void:
	for child in card_container.get_children():
		child.queue_free()
		card_container.remove_child(child)
