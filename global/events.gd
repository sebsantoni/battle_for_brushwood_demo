extends Node

# Card Events
signal card_released(card_ui: CardUI)

# Unit Events
signal unit_hovered(unit: Unit)
signal unit_unhovered()
signal unit_died(unit: Unit)

# Player Events
signal player_died(player: Player)
