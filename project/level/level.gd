class_name Level
extends Node3D

@onready var _ghost_object : Ghost

func _ready() -> void:
	spawn_ghost()
	

func spawn_ghost() -> void:
	_ghost_object = load("res://ghost/ghost.tscn").instantiate()
	get_parent().add_child(_ghost_object)
	var position_z = randf_range(-5, 5)
	_ghost_object.global_position = Vector3(6, 0, position_z)
	_ghost_object.connect("ghost_hit", _on_ghost_entered)


func _on_ghost_entered() -> void:
	spawn_ghost()
