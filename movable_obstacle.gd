extends RigidBody2D


func _ready() -> void:
	position = Vector2(
			randi_range(0, get_window().size.x),
			randi_range(0, get_window().size.y)
	)


func _draw() -> void:
	draw_arc(Vector2.ZERO, 20, 0.0, 6.28, 12, Color.INDIAN_RED, 2.0, false)
