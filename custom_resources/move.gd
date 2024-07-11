class_name Move
extends Resource

enum TargetType {
	Self, Everyone,
	Single_Enemy, Single_Ally, 
	All_Enemies, All_Allies
}

@export var target_type: TargetType

func execute(unit: Unit, targets: Array[Unit]) -> void:
	# maybe do something else here...
	for target in targets:
		pass # do something
