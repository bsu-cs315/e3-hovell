class_name Hand
extends Node3D

var throw_strength : float = 10
var throw_y_direction : float = 0
var min_throw_angle : int = -90
var max_throw_angle : int = 90
var _y_direction_power : int = 5
var _x_offset : int = -10

@onready var _flashlight_object : Flashlight


func _ready() -> void:
	call_deferred("_spawn_flashlight")


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		_throw_flashlight()


func _spawn_flashlight() -> void:
	_flashlight_object = load("res://flashlight/flashlight.tscn").instantiate()
	get_parent().add_child(_flashlight_object)
	_flashlight_object.global_position = global_position


func _throw_flashlight() -> void:
	var _impulse := Vector3(throw_strength,throw_y_direction * _y_direction_power, 0)
	var _position_normalized := Vector3(_x_offset,throw_y_direction, 0).normalized()
	_flashlight_object.apply_impulse(_impulse, _position_normalized)
	_flashlight_object.gravity_scale = 1
