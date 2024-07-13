extends Move

@export var damage: int


func execute(unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		dmg_effect.set_amount(damage)
		dmg_effect.apply_effect(unit, target)
