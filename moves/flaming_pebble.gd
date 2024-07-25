extends Move

@export var damage: int
@export var stacks: int

const Burned = preload("res://status_effects/burned.tres")

func execute(unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		dmg_effect.set_amount(damage)
		dmg_effect.apply_effect(unit, target)
		target.status_handler.apply_status(Burned, stacks)
