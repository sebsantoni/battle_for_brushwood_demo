class_name StatBar
extends GridContainer

@onready var health_stat = $HealthStat
@onready var block_stat = $BlockStat
@onready var drowsy_stat = $DrowsyStat
@onready var strength_stat = $StrengthStat
@onready var asleep_stat = $AsleepStat
@onready var burned_stat = $BurnedStat
@onready var charmed_stat = $CharmedStat
@onready var defence_stat = $DefenceStat

@onready var health_label = $HealthStat/Control/HealthLabel
@onready var block_label = $BlockStat/Control/BlockLabel
@onready var drowsy_label = $DrowsyStat/Control/DrowsyLabel
@onready var asleep_label = $AsleepStat/Control/AsleepLabel
@onready var strength_label = $StrengthStat/Control/StrengthLabel
@onready var burned_label = $BurnedStat/Control/BurnedLabel
@onready var charmed_label = $CharmedStat/Control/CharmedLabel
@onready var defence_label = $DefenceStat/Control/DefenceLabel


func update_label_text(label: Label, amount: int) -> bool:
	if amount == 0:
		return false
	else:
		label.text = str(amount)
		return true


func update_health_label(health: int) -> void:
	if update_label_text(health_label, health):
		health_stat.show()
	else:
		health_stat.hide()


func update_block_label(block: int) -> void:
	if update_label_text(block_label, block):
		block_stat.show()
	else:
		block_stat.hide()


func update_drowsy_label(stacks: int) -> void:
	if update_label_text(drowsy_label, stacks):
		drowsy_stat.show()
	else:
		drowsy_stat.hide()


func update_asleep_label(stacks: int) -> void:
	if update_label_text(asleep_label, stacks):
		asleep_stat.show()
	else:
		asleep_stat.hide()


func update_strength_label(stacks: int) -> void:
	if update_label_text(strength_label, stacks):
		strength_stat.show()
	else:
		strength_stat.hide()


func update_burned_label(stacks: int) -> void:
	if update_label_text(burned_label, stacks):
		burned_stat.show()
	else:
		burned_stat.hide()


func update_charmed_label(stacks: int) -> void:
	if update_label_text(charmed_label, stacks):
		charmed_stat.show()
	else:
		charmed_stat.hide()


func update_defence_label(stacks: int) -> void:
	if update_label_text(defence_label, stacks):
		defence_stat.show()
	else:
		defence_stat.hide()
