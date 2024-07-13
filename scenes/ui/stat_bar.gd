extends HBoxContainer

@onready var health_icon = $HealthStat/HealthIcon
@onready var block_icon = $BlockStat/BlockIcon

@onready var health_label = $HealthStat/Control/HealthLabel
@onready var block_label = $BlockStat/Control/BlockLabel

func update_label_text(icon: TextureRect, label: Label, amount: int) -> void:
	if amount == 0:
		icon.visible = false
		label.visible = false
	label.text = str(amount)

func update_health_label(health: int) -> void:
	update_label_text(health_icon, health_label, health)

func update_block_label(block: int) -> void:
	update_label_text(block_icon, block_label, block)
