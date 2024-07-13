class_name DamageEffect
extends Effect

var amount: int

func apply_effect(from, to):
	var strength_boost = 0
	
	if from.status_handler.has_status("Strength"):
		strength_boost = from.status_handler.statuses["Strength"].stacks
	
	to.take_damage(amount + strength_boost)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
