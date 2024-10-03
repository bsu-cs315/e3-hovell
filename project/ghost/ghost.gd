class_name Ghost
extends RigidBody3D

func _on_body_entered(body: Node) -> void:
	if body.name == "Flashlight":
		$".".queue_free()
	
