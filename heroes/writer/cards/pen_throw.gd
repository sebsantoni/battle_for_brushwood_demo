extends Card

@export var damage: int

func play(player: Player, dropped: bool, target: Unit) ->bool:
	if targeted:
		if not target:
			return false
		else:
			print("card played on target: ", target)
			var dmg_effect = DamageEffect.new()
			dmg_effect.set_amount(damage)
			dmg_effect.apply_effect(player, target)
			return true
	else:
		if target or not dropped:
			return false
		else:
			print("non-targeted card played")
			return true
