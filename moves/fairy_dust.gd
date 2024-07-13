extends Move

@export var stacks: int
const Drowsy = preload("res://status_effects/drowsy.tres")

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		target.status_handler.apply_status(Drowsy, stacks)
