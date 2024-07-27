class_name Tooltip
extends PanelContainer

@onready var description: RichTextLabel = $Description

const TargetType = Move.TargetType
const EffectType = Move.EffectType

var effect_type_description = {
	EffectType.Damage: "attack",
	EffectType.Damage_Boosted: "attack",
	EffectType.Debuff: "apply a debuff to",
	EffectType.Buff: "buff",
	EffectType.Damage_Debuff: "attack and apply a debuff to"
}

var target_type_description = {
	TargetType.Self: " itself", 
	TargetType.Everyone: " everyone",
	TargetType.Single_Enemy: " an enemy",
	TargetType.Single_Ally: " an ally", 
	TargetType.All_Enemies: " all enemies", 
	TargetType.All_Allies: " all allies"
}

var keyword_description = {
	"Exhaust": "Remove from play this encounter",
	"Dragonling": "A tiny dragon that burns enemies",
	"Knight": "A tanky companion that defends allies",
	"Witch": "A disruptive spellcaster",
	"Block": "Negates damage received this turn",
	"Imagine": "Choose 1 of 3 cards to add to your hand",
	"Silence": "Remove all status effects"
}

func _ready() -> void:
	if not description:
		description = RichTextLabel.new()


func set_intent_text(handler: MoveHandler) -> void:
	var move = handler.current_move
	
	var effect_type = move.effect_type
	var target_type = move.target_type
	
	var effect_text = effect_type_description[effect_type]
	var target_text = target_type_description[target_type]
	
	var additional_text = ""
	
	if move.effect_type == EffectType.Damage_Boosted:
		additional_text = ", possibly with bonus damage"
	
	
	var text = "Intends to " + effect_text + target_text + additional_text
	
	self.description.text = text


func set_status_text(status: StatusEffect) -> void:
	var name = status.name
	var stat_desc = status.description 
	
	var text = status.name + ": " + status.description
	
	self.description.text = text


func set_card_text(keyword: String) -> void:
	self.description.text = keyword_description[keyword]
