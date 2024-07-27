class_name IntentUI
extends HBoxContainer

@onready var icon = $Icon
@onready var label = $Control/Label

var move_handler: MoveHandler
var tooltip: Tooltip

func _on_mouse_entered():
	tooltip.set_intent_text(move_handler)
	tooltip.show()


func _on_mouse_exited():
	tooltip.hide()
