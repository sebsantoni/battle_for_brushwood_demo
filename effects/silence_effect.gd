class_name SilenceEffect
extends Effect


func apply_effect(_from, to):
	to.status_handler.clear_statuses()
