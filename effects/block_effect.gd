class_name BlockEffect
extends Effect

var amount: int

func apply_effect(_from, to):
	to.gain_block(amount)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
