class_name Move
extends Resource

enum TargetType {
	Self, Everyone,
	Single_Enemy, Single_Ally, 
	All_Enemies, All_Allies
}

@export var target_type: TargetType

func execute(_unit: Unit, _targets: Array) -> void:
	pass
