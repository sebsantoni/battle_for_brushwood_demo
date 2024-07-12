extends Move


func execute(_unit: Unit, targets: Array[Unit]) -> void:
	for target in targets:
		print("deal 8 damage to:", target)
		print("if statused, deal 12 damage instead")
