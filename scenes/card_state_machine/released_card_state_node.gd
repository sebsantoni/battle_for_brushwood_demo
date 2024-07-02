extends CardStateNode

func enter() -> void:
	Events.card_released.emit(card_ui)
