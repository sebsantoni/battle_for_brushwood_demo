class_name StatBar
extends GridContainer

@onready var health_stat = $HealthStat
@onready var block_stat = $BlockStat
@onready var drowsy_stat = $DrowsyStat
@onready var strength_stat = $StrengthStat
@onready var asleep_stat = $AsleepStat

@onready var health_icon = $HealthStat/HealthIcon
@onready var block_icon = $BlockStat/BlockIcon
@onready var drowsy_icon = $DrowsyStat/DrowsyIcon
@onready var asleep_icon = $AsleepStat/AsleepIcon
@onready var strength_icon = $StrengthStat/StrengthIcon

@onready var health_label = $HealthStat/Control/HealthLabel
@onready var block_label = $BlockStat/Control/BlockLabel
@onready var drowsy_label = $DrowsyStat/Control/DrowsyLabel
@onready var asleep_label = $AsleepStat/Control/AsleepLabel
@onready var strength_label = $StrengthStat/Control/StrengthLabel


func update_label_text(icon: TextureRect, label: Label, amount: int) -> bool:
	if amount == 0:
		return false
	else:
		label.text = str(amount)
		return true


func update_health_label(health: int) -> void:
	if update_label_text(health_icon, health_label, health):
		health_stat.show()
	else:
		health_stat.hide()


func update_block_label(block: int) -> void:
	update_label_text(block_icon, block_label, block)


func update_drowsy_label(stacks: int) -> void:
	if update_label_text(drowsy_icon, drowsy_label, stacks):
		drowsy_stat.show()
	else:
		drowsy_stat.hide()


func update_asleep_label(stacks: int) -> void:
	if update_label_text(asleep_icon, asleep_label, stacks):
		asleep_stat.show()
	else:
		asleep_stat.hide()


func update_strength_label(stacks: int) -> void:
	if update_label_text(strength_icon, strength_label, stacks):
		strength_stat.show()
	else:
		strength_stat.hide()
