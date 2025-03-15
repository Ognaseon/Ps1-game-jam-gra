extends Area3D

const SPEED := 4.0
var dir = 1
func _ready() -> void:
	look_at(Vector3(get_node('/root/Main/Player').position.x,1,get_node('/root/Main/Player').position.z))
func _process(delta: float) -> void:
	
	position += transform.basis * Vector3(0, 0, -SPEED) * delta * dir
	if position.y < 0:
		queue_free()
	if Global.activepowerups["reflection"] == true:

		dir = -1
		
	print(dir)


func _on_area_3d_body_entered(body: Node3D) -> void:
	var candamage = true
	if body.is_in_group("player"):
		Global.hurt = true
		if Global.activepowerups["invincibility"] == true:
			candamage = false
		if candamage == true:
			Global.hurt = true
			Global.health -= 1
		if Global.activepowerups["shield"] == true:

			Global.health += 0.5
			
			queue_free()
			return

		queue_free()


func _on_body_entered(body: Node3D) -> void:
	var candamage = true
	if body.is_in_group("player"):
		Global.hurt = true
		if Global.activepowerups["invincibility"] == true:
			candamage = false
		if candamage == true:
			Global.hurt = true
			Global.health -= 1
		if Global.activepowerups["shield"] == true:

			Global.health += 0.5
			
			queue_free()
			return

		queue_free()
