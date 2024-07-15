class_name DamageEffect
extends Effect

var amount: int

func apply_effect(from, to):
	var strength_boost = from.status_handler.get_status_stacks("Strength")
	
	to.take_damage(amount + strength_boost)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
