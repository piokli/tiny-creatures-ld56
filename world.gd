extends Node2D

var tiny_creature_scene = preload("res://tiny_creature.tscn")
var movable_obstacle_scene = preload("res://movable_obstacle.tscn")


func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn_tiny_creature"):
		var new_creature = tiny_creature_scene.instantiate()
		add_child(new_creature)
	if event.is_action_pressed("spawn_movable_obstacle"):
		var new_obstacle = movable_obstacle_scene.instantiate()
		add_child(new_obstacle)

func _process(delta: float) -> void:
	pass
