extends Node3D

const SPEED := 40.0

func _process(delta: float) -> void:
	look_at(get_node('/root/Main/Player').position)
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if $RayCast3D.is_colliding():
		queue_free()
