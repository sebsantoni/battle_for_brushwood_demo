class_name CardPileUI
extends Control

var card_pile: CardPile
var card_pile_handler: CardPileHandler

@onready var count_icon_left = $CountIconLeft
@onready var count_icon_right = $CountIconRight

@onready var count_label_left = $CountIconLeft/CountLabelLeft
@onready var count_label_right = $CountIconRight/CountLabelRight
var count_label: Label

@onready var card_pile_sprite = $CardPileSprite


func update_count() -> void:
	count_label.text = str(card_pile.size())


func load_ui() -> void:
	card_pile_sprite.texture = card_pile_handler.card_pile_icon
	
	if card_pile.label_right:
		count_icon_right.visible = true
		count_label = count_label_right
	else:
		count_icon_left.visible = true
		count_label = count_label_left

	update_count()
