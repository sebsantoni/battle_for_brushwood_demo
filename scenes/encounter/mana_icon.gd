class_name ManaIcon
extends Panel

@onready var mana_label = $ManaLabel


func update_mana(player: Player) -> void:
	mana_label.text = str(player.mana) + "/" + str(player.hero.max_mana)
