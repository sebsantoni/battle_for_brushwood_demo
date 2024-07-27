class_name CardDescription
extends RichTextLabel

var tooltip: Tooltip


func _on_word_hovered(word: String):
	tooltip.set_card_text(word)
	tooltip.show()


func _on_word_unhovered(word: String):
	tooltip.hide()


