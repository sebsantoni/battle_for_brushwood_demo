class_name CardUI
extends Control

@onready var card_area: Area2D = $CardArea

signal return_to_hand(card_ui: CardUI)

@export_group("Visual Attributes")
var art: TextureRect
var name_: String
var description: String
