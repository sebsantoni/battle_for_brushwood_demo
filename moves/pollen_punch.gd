extends Move

@export var damage: int

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		dmg_effect.set_amount(damage)
		dmg_effect.apply_effect(self, target)
		print("apply Drowsy to:", target)
