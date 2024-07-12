extends Move


func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		print("apply Drowsy to:", target)
