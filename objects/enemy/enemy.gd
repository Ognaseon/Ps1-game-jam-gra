extends Area3D
var angle = randf_range(0,360)
var dia = randf_range(15,20)
var speed = randf_range(0.1,0.5)
var posy = 0
var sin = 0
var type = "normal"
var state = 0
@onready var bullet_spawn_rate = 10
@onready var bullet = preload('res://objects/enemy_bullet/bullet.tscn')

var dead = false
var fallin = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == "normal":
		posy = 0.9
	if type == "creep":
		posy = 0.9
	if type == "flying":
		posy = randf_range(2,8)
	
	$BulletSpawnTime.wait_time = randf() * bullet_spawn_rate
	$BulletSpawnTime.start()
	$Label3D.text = "type: " + type
	$Label3D2.text = "state: " + str(state)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.health <1:
		return
	if dead == false:
		position.x = dia * sin(angle )
		position.z = dia * cos(angle)
		
		if type == "normal":
			angle += delta * speed
		if type == "flying":
			angle += delta * speed
			sin += 1.0
			$Sprite3D.modulate = Color(0.4,0.4,0,1)
		if type == "creep":
			#angle += delta * speed
			dia -= delta/3
			$Sprite3D.modulate = Color(0.4,0,0,1)




		position.y = posy + sin(sin/10.0)
	if dead == true:
		$GPUParticles3D.emitting = true
		if fallin == true:
			position.y -= 0.2
	#if dia > 0:
	#	dia -= delta
	$MeshInstance3D.position = position
	$MeshInstance3D.position.y = 0.2
	
	if position.y < 0.8:
		if dead == true:
			fallin = false
			$GPUParticles3D.emitting = true
			$AnimationPlayer.play("die")


func bullet_spawning():
	var instance = bullet.instantiate()
	instance.position = position
	$bullets.add_child(instance)
	
#go to x = (distance)sin(angle) and y = (distance)cos(angle)

func _on_bullet_spawn_time_timeout() -> void:
	if type == "shooter":
		bullet_spawning()
		$BulletSpawnTime.wait_time = randf() * bullet_spawn_rate

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground"):
		if dead == true:
			
			fallin = false
			$GPUParticles3D.emitting = true
			$AnimationPlayer.play("die")
	if body.is_in_group("player"):
		Global.health -= 1
		$GPUParticles3D.emitting = true
		$AnimationPlayer.play("die")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
