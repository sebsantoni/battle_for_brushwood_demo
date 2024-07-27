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


func update_description(player: Player) -> void:
	var defence_stacks = player.status_handler.get_status_stacks("Defence")
	var blk = block + defence_stacks
	var text = "Deal [color=green]" + str(blk) + "[/color] damage to an enemy."
	self.description = text
