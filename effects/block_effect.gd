class_name BlockEffect
extends Effect

var amount: int

func apply_effect(_from, to):
	var defence_boost = to.status_handler.get_status_stacks("Defence")
	
	to.gain_block(amount + defence_boost)


func set_amount(dmg: int):
	amount = clampi(dmg, 0, dmg)
