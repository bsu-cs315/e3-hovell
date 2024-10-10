class_name Hand
extends Node3D

var throw_strength : float = 20
var throw_y_direction : float = 0
var min_throw_angle : int = -90
var max_throw_angle : int = 90
var _y_direction_power : int = 5
var _x_offset : int = -10
var _z_direction : int

@onready var _flashlight_object : Flashlight

func _ready() -> void:
	call_deferred("_spawn_flashlight")


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		_throw_flashlight()
	elif Input.is_action_pressed("move_left"):
		_flashlight_object.rotation_degrees.y += 1
		_z_direction -= 1
	elif Input.is_action_pressed("move_right"):
		_flashlight_object.rotation_degrees.y -= 1
		_z_direction += 1
	elif Input.is_action_pressed("move_up"):
		_flashlight_object.rotation_degrees.x += 1
	elif Input.is_action_pressed("move_down"):
		_flashlight_object.rotation_degrees.x -= 1
		
	if _flashlight_object.position.y < -5:
		_flashlight_object.queue_free()
		_spawn_flashlight()


func _spawn_flashlight() -> void:
	_flashlight_object = load("res://flashlight/flashlight.tscn").instantiate()
	get_parent().add_child(_flashlight_object)
	_flashlight_object.global_position = global_position
	_flashlight_object.global_rotation_degrees.y = -90
	_x_offset = 0
	throw_y_direction = 0
	_z_direction = 0


func _throw_flashlight() -> void:
	var _impulse := Vector3(throw_strength,throw_y_direction * _y_direction_power, _z_direction)
	var _position_normalized := Vector3(_x_offset,throw_y_direction, 0).normalized()
	_flashlight_object.apply_impulse(_impulse, _position_normalized)
	_flashlight_object.gravity_scale = 1
