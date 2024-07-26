class_name UnitHandler
extends Node2D

const Turn_Start = StatusEffect.ActivationType.Turn_Start
const Turn_End = StatusEffect.ActivationType.Turn_End

var units: Array[Unit]
var allies: Array
var enemies: Array

enum HandlerType {Character, Enemy}
@export var type: HandlerType

const Unit_Scene = preload("res://scenes/unit/unit.tscn")


func _ready() -> void:
	for unit: Unit in self.get_children():
		units.append(unit)
		unit.init()
	
	Events.unit_died.connect(_on_unit_died)
	Events.player_died.connect(_on_player_died)
	Events.unit_summoned.connect(_on_unit_summoned)
	
	if type == HandlerType.Character:
		Events.character_summon_requested.connect(summon_character)


func activate_turn_start_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_turn_start()


func activate_turn_end_statuses() -> void:
	for unit in units:
		unit.status_handler.activate_turn_end()


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


func _on_unit_summoned(unit: Unit, handler: UnitHandler) -> void:
	if handler != self:
		enemies.append(unit)


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


func summon_character(species: Species) -> void:
	print(species.max_hp)
	var character = Unit_Scene.instantiate()
	character.init(Area2D.new(), IntentUI.new(),
	IntentHandler.new(), StatBar.new(), StatusHandler.new(),
	species)
	
	self.add_child(character)
	units.append(character)
	allies.append(character)
	Events.unit_summoned.emit(character, self)
	
	declare_intent(character)
	position_unit(character)


func position_unit(unit: Unit) -> void:
	unit.position = Vector2(80, 80)
