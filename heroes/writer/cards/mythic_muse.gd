extends Card

const Fantasy_Characters = preload("res://card_piles/fantasy_characters.tres")


func play(player: Player, dropped: bool, target: Unit) ->bool:
	if targeted:
		return false
	else:
		if target or not dropped:
			return false
		else:
			Events.imagination_started.emit(Fantasy_Characters)
			return true
