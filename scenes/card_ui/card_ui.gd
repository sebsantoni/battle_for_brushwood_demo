class_name CardUI
extends Control

@onready var card_area: Area2D = $CardArea
@onready var type_diamond = $TypeDiamond
@onready var type_icon = $TypeDiamond/TypeIconContainer/TypeIcon
@onready var cost_icon = $CostIcon
@onready var cost_label = $CostIcon/CostLabel
@onready var name_label = $CardBackground/TextContainer/NameLabel
@onready var description = $CardBackground/TextContainer/Description

@onready var attack_art_container = $CardBackground/ArtContainer/AttackArtContainer
@onready var spell_art_container = $CardBackground/ArtContainer/SpellArtContainer
@onready var aura_art_container = $CardBackground/ArtContainer/AuraArtContainer
@onready var character_art_container = $CardBackground/ArtContainer/CharacterArtContainer

var card: Card
var card_handler: CardHandler

var rarity_colors = {
	'Common': Color(795548, 255),
	'Uncommon': Color.SILVER,
	'Rare': Color.GOLD
}

var type_colors = {
	'Attack': Color.RED,
	'Spell': Color.GREEN,
	'Aura': Color.BLUE,
	'Character': Color.ORANGE
}

var type_icons = {
	'Attack': preload("res://assets/dagger_icon.png"),
	'Spell': preload("res://assets/pixil-frame-0.png"),
	'Aura': preload("res://assets/pixil-frame-0.png"),
	'Character': preload("res://assets/pixil-frame-0.png")
}


func load_ui() -> void:
	# sets the cardUI based on the card's visual attributes
	display_card_type(card.card_type, card.art)
	update_mana_icon(card.rarity, card.cost)
	name_label.text = card.name
	description.text = card.description 


func display_card_type(card_type: Card.CardType, card_art: Texture) -> void:
	var type = Card.CardType.keys()[card_type]
	var container = get_container_by_type(type)
	
	set_type_diamond(type_colors[type], type_icons[type])
	display_art(container, card_art)


func get_container_by_type(type: String) -> Control:
	match type:
		'Attack':
			return attack_art_container
		'Spell':
			return spell_art_container
		'Aura':
			return aura_art_container
		'Character':
			return character_art_container
		_:
			return attack_art_container


func set_type_diamond(color: Color, icon: Texture) -> void:
	type_diamond.color = color
	type_icon.texture = icon


func display_art(container: Control, card_art: Texture) -> void:
	container.visible = true
	container.get_child(0).get_child(0).texture = card_art


func update_mana_icon(rarity: Card.Rarity, cost: int) -> void:
	var stylebox: StyleBoxFlat = get_theme_stylebox("mana_icon").duplicate()
	stylebox.set("bg_color", rarity_colors[Card.Rarity.keys()[rarity]])
	cost_icon.add_theme_stylebox_override("mana_icon", stylebox)
	cost_label.text = str(card.cost)
