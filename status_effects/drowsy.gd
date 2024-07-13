class_name DrowsyStatus
extends StatusEffect


func activate_status(status_owner):
	if stacks == 1:
		status_owner.status_handler.apply_status(AsleepStatus, 3)
