extends Move


func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		print("deal 10 damage to:", target)
