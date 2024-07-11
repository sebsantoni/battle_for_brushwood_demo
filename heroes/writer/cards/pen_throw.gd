extends Card


func play(_player: Player, dropped: bool, target: Unit) ->bool:
	if targeted:
		if not target:
			return false
		else:
			print("card played on target: ", target)
			return true
	else:
		if target or not dropped:
			return false
		else:
			print("non-targeted card played")
			return true
