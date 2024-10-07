extends Node

const DEFAULT_MASS : float = 1.0
const DEFAULT_MAX_SPEED : float = 1000.0
const DEFAULT_MAX_FORCE : float = 1000.0


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


static func flee(
		velocity : Vector2,
		global_position : Vector2,
		target_position : Vector2,
		delta_time : float,
		mass := DEFAULT_MASS,
		max_speed := DEFAULT_MAX_SPEED,
		max_force := DEFAULT_MAX_FORCE,
	) -> Vector2:
	var desired_velocity := (target_position - global_position).normalized() * max_speed * (-1)
	var steering := (desired_velocity - velocity).limit_length(max_force) / mass
	var new_velocity := (velocity + steering * delta_time).limit_length(max_speed)
	return new_velocity


static func pursue():
	# seek target's predicted position
	pass


static func evade():
	# flee target's predicted position
	pass


static func offset_pursue():
	# seek target's predicted position which is offset by r
	pass


static func arrive(
		velocity : Vector2,
		global_position : Vector2,
		target_position : Vector2,
		delta_time : float,
		mass := DEFAULT_MASS,
		max_speed := DEFAULT_MAX_SPEED,
		max_force := DEFAULT_MAX_FORCE,
		arrive_distance := 100.0,
		arrive_slowing := 300.0,
	) -> Vector2:
	# just the slowing down part
	var target_offset := (target_position - global_position)
	var target_distance := target_offset.length()
	var new_velocity := Vector2.ZERO
	if target_distance > arrive_distance:
		new_velocity = seek(
				velocity,
				global_position,
				target_position,
				delta_time,
				mass,
				max_speed,
				max_force,
		)
	else:
		var ramped_speed = max_speed * (target_distance / arrive_slowing)
		var clipped_speed = min(ramped_speed, max_speed)
		var desired_velocity = clipped_speed * target_offset.normalized()
		var steering = (desired_velocity - velocity).limit_length(max_force) / mass
		new_velocity = (velocity + steering * delta_time).limit_length(max_speed)
	return new_velocity


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
