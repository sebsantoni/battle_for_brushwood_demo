class_name IntentArrowDrawer
extends Control


func _ready() -> void:
	Events.unit_died.connect(_on_entity_died)
	Events.player_died.connect(_on_entity_died)


func draw_target_lines(unit: Unit) -> void:
	'''Draws lines between unit and its targets'''
	print("drawing target lines")
	var targets = unit.species.move_handler.current_targets
	for target in targets:
		if target == unit or not target:
			continue
			
		var line: Line2D = Line2D.new()
		
		var unit_vertex: Vector2 = get_sprite_vertex(unit, -1)
		var target_vertex: Vector2 = get_sprite_vertex(target, 1)
		
		line.add_point(unit_vertex)
		line.add_point(target_vertex)
		
		line.default_color = Color.RED
		line.width = 2
		
		self.add_child(line)


func get_sprite_vertex(sprite, direction: int) -> Vector2:
	'''direction = -1 means left, +1 = right'''
	var x = sprite.global_position.x + direction * sprite.texture.get_width()/2 * sprite.scale.x
	var y = sprite.global_position.y
	return Vector2(x, y)


func hide_target_lines() -> void:
	for line in self.get_children():
		line.queue_free()


func _on_entity_died(_entity) -> void:
	hide_target_lines()
