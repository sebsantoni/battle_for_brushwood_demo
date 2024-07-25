class_name HealEffect
extends Effect

var amount: int

func apply_effect(_from, to):
	to.heal(amount)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
