class_name Encounter
extends Node2D

@onready var card_drop_area = $CardDropArea

func _ready() -> void:
	Events.card_released.connect(_on_card_released)


func _on_card_released(card_ui: CardUI) -> void:
	if card_in_drop_area(card_ui):
		var card: Card = card_ui.get_parent()
		# attempt to play the card


func card_in_drop_area(card_ui: CardUI) -> bool:
	for area in card_drop_area.get_overlapping_areas():
		if area == card_ui.card_area:
			return true
	
	return false
