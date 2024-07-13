class_name StatusEffect
extends Resource

enum StackType {Time, Magnitude, Non_Stackable}
enum ActivationType {Round_Start, Round_End, Non_Activable}
# non activable = modifier!

var stacks: int

@export var name: String
@export var stack_type: StackType
@export var activation_type: ActivationType
@export var unique: bool


func increase_stacks(amount: int) -> void:
	if stack_type == StackType.Non_Stackable:
		return
	else:
		stacks += amount


func activate_status(_status_owner) -> void:
	pass
