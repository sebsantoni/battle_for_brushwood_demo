class_name Move
extends Resource

enum TargetType {
	Self, Everyone,
	Single_Enemy, Single_Ally, 
	All_Enemies, All_Allies
}

enum EffectType {
	Damage,
	Damage_Boosted,
	Debuff,
	Buff,
	Damage_Debuff
}

@export var target_type: TargetType
@export var effect_type: EffectType

func execute(_unit: Unit, _targets: Array) -> void:
	pass
