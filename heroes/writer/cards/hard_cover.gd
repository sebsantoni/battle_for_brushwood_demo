extends Card

@export var block: int

func play(player: Player, dropped: bool, target, is_enemy: bool) ->bool:
	if targeted:
		return false
	else:
		if target or not dropped:
			return false
		else:
			var block_effect = BlockEffect.new()
			block_effect.set_amount(block)
			block_effect.apply_effect(player, player)
			return true
