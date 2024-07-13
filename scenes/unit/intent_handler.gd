extends Control

var unit: Unit
var move_handler: MoveHandler
var intent_ui: HBoxContainer

var Effect_Icons: Dictionary = {
	'Damage': preload("res://assets/dagger_icon.png"),
	'Damage_Boosted': preload("res://assets/dagger_icon.png"),
	'Debuff': preload("res://assets/shield_icon.png"),
	'Buff': preload("res://assets/shield_icon.png"),
	'Damage_Debuff': preload("res://assets/dagger_icon.png")
}


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
	var effect = Move.EffectType.keys()[move.effect_type]
	
	var text: String = ""
	match effect:
		'Damage':
			text = str(move.damage)
		'Damage_Boosted':
			text = str(move.damage)
		'Debuff':
			pass
		'Buff':
			pass
		'Damage_Debuff':
			text = str(move.damage)
	
	intent_ui.icon.texture = Effect_Icons[effect]
	intent_ui.label.text = text
