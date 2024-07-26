extends Card


func play(player: Player, dropped: bool, target, is_enemy: bool) ->bool:
	if targeted:
		if not target:
			return false
		else:
			var silence_effect = SilenceEffect.new()
			silence_effect.apply_effect(player, target)
			return true
	else:
		if target or not dropped:
			return false
		else:
			return true
