extends Move


func execute(_unit: Unit, targets: Array[Unit]) -> void:
	for target in targets:
		print("deal 6 damage to:", target)
