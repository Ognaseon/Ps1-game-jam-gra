extends RayCast3D

@onready var beam_mesh = $MeshInstance3D2

func _process(delta: float) -> void:
	var cast_point
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		beam_mesh.mesh.height = cast_point.y
