class_name Ghost
extends RigidBody3D

var moving_left : bool = true

func _on_body_entered(_body: Node) -> void:
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
