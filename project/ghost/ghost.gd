class_name Ghost
extends RigidBody3D

signal ghost_hit

var moving_left : bool

func _ready() -> void:
	var starting_dir = randi_range(0, 1)
	if starting_dir == 0:
		moving_left = false
	else:
		moving_left = true
	

func _on_body_entered(_body: Node) -> void:
	ghost_hit.emit()
	$".".queue_free()
	
	
func _physics_process(delta: float) -> void:
	if position.z < 5 and not moving_left:
		position.z += 1 * delta
	elif position.z >= 5 and not moving_left:
		moving_left = true
	elif position.z >= -5 and moving_left:
		position.z -= 1 * delta
	elif position.z <= -5 and moving_left:
		moving_left = false
