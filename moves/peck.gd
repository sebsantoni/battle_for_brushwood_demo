extends Move


func execute(_unit: Unit, targets: Array[Unit]) -> void:
	for target in targets:
		print("deal 10 damage to:", target)
