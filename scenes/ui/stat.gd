class_name Stat
extends HBoxContainer

@export var status: StatusEffect

signal open_stat_tooltip(stat: StatusEffect)
signal close_stat_tooltip


func _on_mouse_entered():
	open_stat_tooltip.emit(status)


func _on_mouse_exited():
	close_stat_tooltip.emit()
