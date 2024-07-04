class_name Hero
extends Resource

@export_group("Battle Attributes")
@export var max_mana: int = 3
@export var max_hp: int
@export var cards_per_turn: int
@export var starting_deck: String #will be CardPile once that's implemented!


#@export_group("Non-Battle Attributes")
#@export var draftable_cards: String # will be CardPile
## pause on this...we may just make this something handled by CardRewards
# can later have passive effects and stuff specific to each hero!
# "each hero has a passive ability imbued within their spirit...
# as for you, Ryder (?), you have the ability to bring your characters
# to life! You can draft Character cards, a unique kind of card that joins
# you in battle!"

@export_group("Visual Attributes")
@export var name: String
@export var art: Texture
@export_multiline var description: String
