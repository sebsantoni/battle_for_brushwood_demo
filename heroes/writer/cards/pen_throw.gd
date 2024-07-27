extends Card

@export var damage: int

func play(player: Player, dropped: bool, target, is_enemy: bool) ->bool:
	if targeted:
		if not target:
			return false
		elif is_enemy:
			var dmg_effect = DamageEffect.new()
			dmg_effect.set_amount(damage)
			dmg_effect.apply_effect(player, target)
			return true
		else:
			return false
	else:
		if target or not dropped:
			return false
		else:
			return true


func update_description(player: Player) -> void:
	var strength_stacks = player.status_handler.get_status_stacks("Strength")
	var dmg = damage + strength_stacks
	var text = "Deal [color=red]" + str(dmg) + "[/color] damage to an enemy."
	self.description = text
