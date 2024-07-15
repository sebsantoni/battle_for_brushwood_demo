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
	
	Events.unit_died.connect(_on_unit_died)
	Events.player_died.connect(_on_player_died)


func activate_turn_start_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_statuses_by_activation_type(Turn_Start)


func activate_turn_end_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_statuses_by_activation_type(Turn_End)


func declare_intents() -> void:
	for unit in units:
		declare_intent(unit)


func declare_intent(unit: Unit) -> void:
	unit.prepare(allies, enemies)
	unit.intent_handler.update_ui()


func trigger_moves() -> void:
	for unit in units:
		unit.move()


func is_empty() -> bool:
	return units.is_empty()


func _on_unit_died(unit: Unit) -> void:
	if unit in units:
		units.erase(unit)
	
	if unit in allies:
		allies.erase(unit)
	
	if unit in enemies:
		enemies.erase(unit)
	
	remove_dead_target(unit)


func _on_player_died(player: Player) -> void:
	if player in allies:
		allies.erase(player)
	
	if player in enemies:
		enemies.erase(player)
	
	remove_dead_target(player)


func remove_dead_target(target) -> void:
	for unit in units:
		var move_handler = unit.species.move_handler
		if target in move_handler.current_targets:
			move_handler.remove_target(target)
			declare_intent(unit)

