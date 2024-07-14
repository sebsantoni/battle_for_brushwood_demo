class_name UnitHandler
extends Node2D

const Turn_Start = StatusEffect.ActivationType.Turn_Start
const Turn_End = StatusEffect.ActivationType.Turn_End

var units: Array[Unit]
var allies: Array
var enemies: Array


func _ready() -> void:
	for unit: Unit in self.get_children():
		units.append(unit)


func activate_turn_start_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_statuses_by_activation_type(Turn_Start)


func activate_turn_end_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_statuses_by_activation_type(Turn_End)


func declare_intents() -> void:
	for unit in units:
		unit.prepare(allies, enemies)
		unit.intent_handler.update_ui()


func trigger_moves() -> void:
	for unit in units:
		unit.move()


func is_empty() -> bool:
	return units.is_empty()
