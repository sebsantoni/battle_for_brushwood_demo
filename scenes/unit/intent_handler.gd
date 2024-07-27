class_name IntentHandler
extends Control

var unit: Unit
var move_handler: MoveHandler
var intent_ui: HBoxContainer

var Effect_Icons: Dictionary = {
	'Damage': preload("res://assets/dagger_icon.png"),
	'Damage_Boosted': preload("res://assets/dagger_icon.png"),
	'Debuff': preload("res://assets/debuff.png"),
	'Buff': preload("res://assets/buff.png"),
	'Damage_Debuff': preload("res://assets/dagger_debuff_icon.png")
}

const Asleep_Icon = preload("res://assets/asleep.png")


func init(unit_: Unit) -> void:
	unit = unit_
	move_handler = unit.species.move_handler
	intent_ui = unit.intent_ui


func _on_mouse_entered():
	Events.unit_hovered.emit(unit)


func _on_mouse_exited():
	Events.unit_unhovered.emit()


func update_ui() -> void:
	var move = move_handler.current_move
	
	if unit.status_handler.has_status("Asleep"):
		intent_ui.icon.texture = Asleep_Icon
		intent_ui.label.text = str(unit.status_handler.get_status_stacks("Asleep"))
		return
	
	if not move:
		return
	
	var effect = Move.EffectType.keys()[move.effect_type]
	
	var text: String = ""
	var strength_boost = unit.status_handler.get_status_stacks("Strength")
	
	match effect:
		'Damage':
			text = str(move.damage + strength_boost)
		'Damage_Boosted':
			text = str(move.damage + strength_boost) + "-" + str(move.bonus_damage + strength_boost)
		'Debuff':
			pass
		'Buff':
			pass
		'Damage_Debuff':
			text = str(move.damage + strength_boost)
	
	intent_ui.icon.texture = Effect_Icons[effect]
	intent_ui.label.text = text
