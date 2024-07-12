extends Move


func execute(_unit: Unit, targets: Array[Unit]) -> void:
	for target in targets:
		print("apply Drowsy to:", target)
