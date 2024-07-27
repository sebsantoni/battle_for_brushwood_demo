class_name BurnedStatus
extends StatusEffect

func activate_status(status_owner) -> void:
	var damage = status_owner.status_handler.get_status_stacks("Burned")
	status_owner.take_damage(damage)
