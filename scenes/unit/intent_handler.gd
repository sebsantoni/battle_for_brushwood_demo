extends Control

@onready var intent_ui = $IntentUI

var targets: Array
@onready var unit = $".."

func _draw() -> void:
	var unit_pos = unit.global_position
	
	for target in targets:
		if target != unit:
			var target_pos = target.global_position
			draw_line(unit_pos, target_pos, Color.WHITE, 2)


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.


func update_ui() -> void:
	pass
	

func draw_target_arrows() -> void:
	pass
