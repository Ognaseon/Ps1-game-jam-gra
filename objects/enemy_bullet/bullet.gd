extends Node3D

const SPEED := 2.0

func _process(delta: float) -> void:
	look_at(get_node('/root/Main/Player').position)
	position += transform.basis * Vector3(0, 0, -SPEED) * delta



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.health -= 1
		queue_free()
