extends Area3D

const SPEED := 4.0

func _ready() -> void:
	look_at(Vector3(get_node('/root/Main/Player').position.x,1,get_node('/root/Main/Player').position.z))
func _process(delta: float) -> void:
	
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if position.y < 0:
		queue_free()



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.health -= 1
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.health -= 1
		queue_free()
	
