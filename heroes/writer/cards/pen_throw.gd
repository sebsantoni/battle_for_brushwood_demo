extends CardResource


func play(dropped: bool, target: Enemy) -> void:
	if targeted:
		if not target:
			return
		else:
			print("card played on target: ", target)
	else:
		if target or not dropped:
			return
		else:
			print("non-targeted card played")
