class_name StatusHandler
extends Control

const Time_ = StatusEffect.StackType.Time

const Round_Start = StatusEffect.ActivationType.Round_Start
const Round_End = StatusEffect.ActivationType.Round_End
const Non_Activable = StatusEffect.ActivationType.Non_Activable

var statuses: Dictionary = {} # status name : status effect
var status_owner # the entity who owns this handler


func apply_status(status, stacks: int) -> void:
	'''
	Precondition: stacks is null iff status is Non-Stackable
	Applies status to the status holder, either incrementing it
	or adding it for the first time
	'''
	if status.name in statuses and not status.unique:
		if stacks:
			statuses[status.name].increase_stacks(stacks)
	else:
		statuses[status.name] = status.duplicate()
		statuses[status.name].increase_stacks(stacks)


func activate_round_start() -> void:
	activate_statuses_by_activation_type(Round_Start)


func activate_round_end() -> void:
	activate_statuses_by_activation_type(Round_End)


func activate_statuses_by_activation_type(type: StatusEffect.ActivationType) -> void:
	if type == Non_Activable:
		return
	
	var stats = get_statuses_by_activation_type(type)
	
	for stat in stats:
		stat.activate_status(status_owner)
		
		if stat.stack_type == Time_:
			stat.increase_stacks(-1)
		
		if stat.stacks == 0:
			statuses.erase(stat.name)


func get_statuses_by_activation_type(type: StatusEffect.ActivationType) -> Array[StatusEffect]:
	var statuses_arr: Array = []
	
	for status: StatusEffect in statuses.values():
		if status.activation_type == type:
			statuses_arr.append(status)
	
	return statuses_arr


func is_statused() -> bool:
	# may want to one day differentiate between positive and negative
	# statuses as an attribute! Thus, this would only be for negative
	return not statuses.is_empty()


func has_status(status: String) -> bool:
	return status in statuses

