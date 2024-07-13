extends Control

var unit: Unit
var move_handler: MoveHandler
var intent_ui: HBoxContainer


func _on_mouse_entered():
	Events.unit_hovered.emit(unit)


func _on_mouse_exited():
	Events.unit_unhovered.emit()


func update_ui() -> void:
	pass
