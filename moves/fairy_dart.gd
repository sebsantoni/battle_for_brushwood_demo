extends Move

@export var base_damage: int
@export var statused_damage: int

func execute(_unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		dmg_effect.set_amount(base_damage)
		dmg_effect.apply_effect(self, target)
		print("if statused, would have dealt: ", statused_damage)
