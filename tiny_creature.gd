extends CharacterBody2D

@export_category("Vehicle Params")
@export var mass : float = 0.1
@export var max_force : float = 500.0
@export var max_speed : float = 500.0
@export var target_node : Node = null

var steering_force : Vector2 = Vector2.ZERO
var _position : Vector2 = Vector2.ZERO
var _velocity : Vector2 = Vector2.ZERO
var _orientation : Vector2 = Vector2.DOWN
# and position, velocity, orientation

var obstacle_avoidance_enabled := false
var push_force : float = 100.0


func _ready() -> void:
	position = Vector2(
			randi_range(0, get_window().size.x),
			randi_range(0, get_window().size.y)
	)


func _process(delta: float) -> void:
	var target := Vector2.ZERO
	if target_node != null:
		target = target_node.position
	else:
		target = get_global_mouse_position()
	
	if obstacle_avoidance_enabled and $ObstacleAvoidance.is_colliding():
		var obstacle_pos = $ObstacleAvoidance.get_collision_point(0) # TODO: get the neartest
		var dir_vec := velocity.normalized()
		var dir_to_collision_point := Vector2(obstacle_pos - position).normalized()
		var opposite_of_nearest_obstacle = \
				dir_to_collision_point.reflect(dir_vec) - \
				dir_to_collision_point.project(dir_vec)
		
		velocity = SteerigBehaviors.seek(
				velocity,
				position,
				position + opposite_of_nearest_obstacle,
				delta,
				mass,
				max_speed,
				max_force,
		)
	else:
		velocity = SteerigBehaviors.arrive(
				velocity,
				position,
				target,
				delta,
				mass,
				max_speed,
				max_force,
		)
	
	move_and_slide()
	_orientation = velocity.normalized()
	rotation = Vector2.DOWN.angle_to(_orientation)
	position = infinite_position(position)
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
	$ObstacleAvoidance.enabled = obstacle_avoidance_enabled
	$ObstacleAvoidance.target_position = \
		$ObstacleAvoidance.target_position.normalized() * velocity.length() * 0.1


func _draw():
	draw_arc(Vector2.ZERO, 12, 0.0, 6.28, 12, Color(1.0, 1.0, 1.0), 2.0, false)
	if obstacle_avoidance_enabled:
		draw_rect($ObstacleAvoidance.shape.get_rect().expand($ObstacleAvoidance.target_position),
			Color.GRAY, false, 1.0, false)


func infinite_position(pos : Vector2) -> Vector2:
	if pos.x > get_window().size.x:
		pos.x = 0
	if pos.x < 0:
		pos.x = get_window().size.x
	if pos.y > get_window().size.y:
		pos.y = 0
	if pos.y < 0:
		pos.y = get_window().size.y
	return pos
