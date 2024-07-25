extends Move

@export var stacks: int
const Charmed = preload("res://status_effects/charmed.tres")

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		target.status_handler.apply_status(Charmed, stacks)
