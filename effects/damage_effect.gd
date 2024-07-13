class_name DamageEffect
extends Effect

var amount: int

func apply_effect(_from, to):
	to.take_damage(amount)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
