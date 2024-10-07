extends CharacterBody2D

@export_category("Vehicle Params")
@export var mass : float
@export var max_force : float
@export var max_speed : float

var steering_force : Vector2 = Vector2.ZERO
var _position : Vector2 = Vector2.ZERO
var _velocity : Vector2 = Vector2.ZERO
var _orientation : Vector2 = Vector2.UP
# and position, velocity, orientation


func _ready() -> void:
	position = Vector2(
			randi_range(0, get_window().size.x),
			randi_range(0, get_window().size.y)
	)

func _process(delta: float) -> void:
	var target := get_global_mouse_position()
	velocity = SteerigBehaviors.seek(
			velocity,
			position,
			target,
			delta
	)
	move_and_slide()
	position = infinite_position(position)
	_orientation = velocity.normalized()
	rotation = Vector2.UP.angle_to(_orientation)

func _draw():
	draw_arc(Vector2(0, 0), 12, 0.0, 6.28, 12, Color(1.0, 1.0, 1.0), 2.0, false)

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
