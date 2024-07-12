class_name MoveHandler
extends Resource

@export var move_pool: Dictionary # Move: Weight
var total_weight: float = 0.0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var current_move: Move
var current_targets: Array

func init() -> void:
	if total_weight == 0.0:
		set_total_weight()
	

func prepare(unit, allies, enemies) -> void:
	current_move = get_move()
	current_targets = get_targets(unit, current_move, allies, enemies)


func execute(unit) -> void:
	current_move.execute(unit, current_targets)


func get_move() -> Move:
	var rand_wgt = rng.randf_range(0.0, total_weight)
	for move in move_pool:
		rand_wgt -= move_pool[move]
		if rand_wgt < 0:
			return move
	
	return move_pool.keys()[0]


func get_targets(unit: Unit, move: Move, allies: Array, enemies: Array) -> Array:
	match move.target_type:
		move.TargetType.Self:
			return [unit]
		move.TargetType.Everyone:
			return allies + enemies
		move.TargetType.Single_Enemy:
			return [get_single_target(enemies)]
		move.TargetType.Single_Ally:
			return [get_single_target(allies)]
		move.TargetType.All_Enemies:
			return enemies
		move.TargetType.All_Allies:
			return allies
		_:
			return []


func get_single_target(targets: Array):
	# for now, this is random! can, in future, make it
	# specifically avoid the player, bosses, etc.
	var rnd_indx = rng.randi_range(0, len(targets) - 1)
	return targets[rnd_indx]


func set_total_weight() -> void:
	for weight in move_pool.values():
		total_weight += weight
