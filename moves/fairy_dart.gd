extends Move

@export var damage: int
@export var bonus_damage: int

func execute(unit: Unit, targets: Array) -> void:
	for target in targets:
		var dmg_effect = DamageEffect.new()
		
		if target.status_handler.is_statused():
			dmg_effect.set_amount(bonus_damage)
		else:
			dmg_effect.set_amount(damage)
			
		dmg_effect.apply_effect(unit, target)
