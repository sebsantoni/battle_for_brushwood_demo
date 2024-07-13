extends Move

@export var stacks: int
const Strength = preload("res://status_effects/strength.tres")

func execute(unit: Unit, _targets: Array) -> void:
	unit.status_handler.apply_status(Strength, stacks)
