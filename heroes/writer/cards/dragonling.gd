extends Card


func play(player: Player, dropped: bool, target, is_enemy: bool) ->bool:
	if targeted:
		return false
	else:
		if target or not dropped:
			return false
		else:
			Events.character_summon_requested.emit(species)
			return true
