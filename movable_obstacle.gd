extends RigidBody2D


func _ready() -> void:
	position = Vector2(
			randi_range(0, get_window().size.x),
			randi_range(0, get_window().size.y)
	)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	position = infinite_position(position)


func _draw() -> void:
	draw_arc(Vector2.ZERO, 20, 0.0, 6.28, 12, Color.INDIAN_RED, 2.0, false)


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
