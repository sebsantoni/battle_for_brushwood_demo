extends Control

var unit: Unit
var move_handler: MoveHandler
var intent_ui: HBoxContainer


func init(unit_: Unit) -> void:
	unit = unit_
	move_handler = unit.species.move_handler
	intent_ui = unit.intent_ui


func _on_mouse_entered():
	Events.unit_hovered.emit(unit)


func _on_mouse_exited():
	Events.unit_unhovered.emit()


func update_ui() -> void:
	pass
