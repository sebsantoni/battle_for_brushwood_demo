extends Move

@export var heal: int


func execute(unit: Unit, targets: Array) -> void:
	for target in targets:
		var heal_effect = HealEffect.new()
		heal_effect.set_amount(heal)
		heal_effect.apply_effect(unit, target)
