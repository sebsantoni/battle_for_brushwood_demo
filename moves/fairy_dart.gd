extends Move

@export var damage: int
@export var bonus_damage: int

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		dmg_effect.set_amount(damage)
		dmg_effect.apply_effect(self, target)
		print("if statused, would have dealt: ", bonus_damage)
