extends Move

@export var stacks: int
const Defence = preload("res://status_effects/defence.tres")

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		target.status_handler.apply_status(Defence, stacks)
