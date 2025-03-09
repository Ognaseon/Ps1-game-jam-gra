extends Area3D
var angle = randf_range(0,360)
var dia = randf_range(15,20)
var speed = randf_range(0.1,0.5)
var posy = 0
var sin = 0
var dead = false
var fallin = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	posy = position.y
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dead == false:
		position.x = dia * sin(angle )
		position.z = dia * cos(angle)
		angle += delta * speed
		sin += 1.0
		position.y = posy + sin(sin/10.0)
	if dead == true:
		if fallin == true:
			position.y -= 0.2

#go to x = (distance)sin(angle) and y = (distance)cos(angle)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground"):
		fallin = false
		$AnimationPlayer.play("die")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
