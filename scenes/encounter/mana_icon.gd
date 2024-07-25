class_name ManaIcon
extends TextureRect

@onready var mana_label = $ManaLabel

@export var player: Player # the player this icon is associated with


func _ready() -> void:
	player.mana_changed.connect(update_mana)
	update_mana()

func update_mana() -> void:
	mana_label.text = str(player.mana) + "/" + str(player.hero.max_mana)
