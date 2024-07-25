extends Move

@export var block: int


func execute(unit: Unit, targets: Array) -> void:
	for target in targets:
		var block_effect = BlockEffect.new()
		block_effect.set_amount(block)
		block_effect.apply_effect(unit, target)
