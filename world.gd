extends Node2D

var tiny_creature_scene = preload("res://tiny_creature.tscn")


func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var new_creature = tiny_creature_scene.instantiate()
		add_child(new_creature)

func _process(delta: float) -> void:
	pass
