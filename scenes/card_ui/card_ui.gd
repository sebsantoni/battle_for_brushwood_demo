class_name CardUI
extends Control

@onready var card_area: Area2D = $CardArea
@onready var type_diamond = $TypeDiamond
@onready var type_icon = $TypeDiamond/TypeIcon
@onready var cost_icon = $CostIcon
@onready var cost_label = $CostIcon/CostLabel
@onready var name_label = $CardBackground/TextContainer/NameLabel
@onready var description = $CardBackground/TextContainer/Description

signal return_to_hand(card_ui: CardUI)

var card: CardResource

const Attack = CardResource.CardType.Attack
const Spell = CardResource.CardType.Spell
const Aura = CardResource.CardType.Aura
const Character = CardResource.CardType.Character

const Common = CardResource.Rarity.Common
const Uncommon = CardResource.Rarity.Uncommon
const Rare = CardResource.Rarity.Rare

var rarity_colors = {
	Common: Color(795548, 255),
	Uncommon: Color.SILVER,
	Rare: Color.GOLD
}

var type_colors = {
	Attack: Color.RED,
	Spell: Color.GREEN,
	Aura: Color.BLUE,
	Character: Color.ORANGE
}

var type_icons = {
	Attack: preload("res://assets/pixil-frame-0.png"),
	Spell: preload("res://assets/pixil-frame-0.png"),
	Aura: preload("res://assets/pixil-frame-0.png"),
	Character: preload("res://assets/pixil-frame-0.png")
}

var type_containers = {
	Attack: $CardBackground/ArtContainer/AttackArtContainer,
	Spell: $CardBackground/ArtContainer/AttackArtContainer,
	Aura: $CardBackground/ArtContainer/AttackArtContainer,
	Character: $CardBackground/ArtContainer/AttackArtContainer
}


func load_ui() -> void:
	# sets the cardUI based on the card's visual attributes
	display_card_type(card.card_type, card.card_art)
	update_mana_icon(card.rarity, card.cost)
	name_label.text = card.name
	description.text = card.description 


func display_card_type(card_type: CardResource.CardType, card_art: Texture) -> void:
	set_type_diamond(type_colors[card_type], type_icons[card_type])
	display_art(type_containers[card_type], card_art)


func set_type_diamond(color: Color, icon: Texture) -> void:
	type_diamond.color = color
	type_icon.texture = icon


func display_art(container: Control, card_art: Texture) -> void:
	container.visible = true
	container.get_chldren(0).get_children(0).texture = card_art


func update_mana_icon(rarity: CardResource.Rarity, cost: int) -> void:
	var stylebox: StyleBoxFlat = get_theme_stylebox(cost_icon).duplicate()
	stylebox.set("bg_color", rarity_colors[rarity])
	cost_label.text = card.cost
