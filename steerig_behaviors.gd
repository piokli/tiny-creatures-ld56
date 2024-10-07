extends Node

const DEFAULT_MASS : float = 1.0
const DEFAULT_MAX_SPEED : float = 1000
const DEFAULT_MAX_FORCE : float = 1000


## Main steering functions
static func seek(
		velocity : Vector2,
		global_position : Vector2,
		target_position : Vector2,
		delta_time : float,
		mass := DEFAULT_MASS,
		max_speed := DEFAULT_MAX_SPEED,
		max_force := DEFAULT_MAX_FORCE,
	) -> Vector2:
	var desired_velocity := (target_position - global_position).normalized() * max_speed
	var steering := (desired_velocity - velocity).limit_length(max_force) / mass
	var new_velocity := (velocity + steering * delta_time).limit_length(max_speed)
	return new_velocity


static func flee():
	pass


static func pursue():
	pass


static func evade():
	pass


static func offset_pursuit():
	pass


static func arrive():
	pass


static func avoid_obstacles():
	pass


static func wander():
	pass


## Boid / flock related steering
static func boid_separation():
	pass


static func boid_alignment():
	pass


static func boid_cohesion():
	pass
