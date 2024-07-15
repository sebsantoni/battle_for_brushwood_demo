class_name DrowsyStatus
extends StatusEffect

const Asleep = preload("res://status_effects/asleep.tres")

func activate_status(status_owner):
	if stacks == 1:
		status_owner.status_handler.apply_status(Asleep, 3)
