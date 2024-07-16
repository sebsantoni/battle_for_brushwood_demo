extends Card

@export var block: int

func play(player: Player, dropped: bool, target: Unit) ->bool:
	if targeted:
		if not target:
			return false
		else:
			return false
	else:
		if target or not dropped:
			return false
		else:
			var block_effect = BlockEffect.new()
			block_effect.set_amount(block)
			block_effect.apply_effect(player, player)
			return true
