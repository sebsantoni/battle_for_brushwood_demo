extends Node

# Card Events
signal card_released(card_ui: CardUI)
signal add_to_hand_requested(card: Card)

# Unit Events
signal unit_hovered(unit: Unit)
signal unit_unhovered()
signal unit_died(unit: Unit)
signal unit_summoned(unit: Unit, handler: UnitHandler)

# Character Events
signal character_summon_requested(species: Species)

# Player Events
signal player_died(player: Player)

# Imagination Events
signal imagination_started(imagination_pool: CardPile)
signal imagination_ended()
