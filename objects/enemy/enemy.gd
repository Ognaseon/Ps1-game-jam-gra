extends Area3D
var angle = randf_range(0,360)
var dia = randf_range(15,20)
var speed = randf_range(0.1,0.5)
var posy = 0
var sin = 0
var type = "normal"
var state = 0.0
@onready var bullet_spawn_rate = 20
@onready var bullet = preload('res://objects/enemy_bullet/bullet.tscn')
var oncursor = [false,0]
var dead = false
var fallin = true
var canspawnbullet = true
var dir = 1
var dia1 = 0
var slowness = 0
var ispeed = 0
var deathsound = randi_range(0,1)
var onetime = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ispeed = speed
	if type == "normal":
		posy = 0.9
	if type == "creep":
		posy = 0.9
	if type == "dodger":
		posy = randf_range(3,10)
		speed = randf_range(0.5,1)
		ispeed = speed
		dia1 = dia
	if type == "flying":
		posy = randf_range(2,8)
	
	
	#$Label3D.text = "type: " + type
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	speed = ispeed
	var freeze = false
	var slowed = false
	var scared = false
	var week = false
	
	
	if Global.activepowerups["slowdown"] == true:
		slowed = true
		speed = ispeed /3
	if Global.activepowerups["freeze"] == true:
		speed = 0
		freeze = true
	if Global.activepowerups["shield"] == true:
		week = true
	if Global.activepowerups["scary"] == true:
		scared = true
		dia += delta
#	$Label3D2.text = "state: " + str(state)
	if Global.health <1:
		return
	
	if position.y < 1:
		if dead == true:
			set_collision_layer_value(1,false)
			$blood.show()
			fallin = false
			$GPUParticles3D.emitting = true
			$AnimationPlayer.play("die")
	if dead == false:
		position.x = dia * sin(angle )
		position.z = dia * cos(angle) 
		
		if type == "normal":
			angle += delta * speed
			if state > 25:
				dia -= delta/4
			state += delta
			position.y = posy
		if type == "flying":
			angle += delta * speed
			sin += 1.0
			$Sprite3D.modulate = Color(0.4,0.4,0,1)
			state += delta
			if state > 5:
				if canspawnbullet == true:
					$BulletSpawnTime.wait_time = bullet_spawn_rate * randf_range(0.7,1.3)
					$BulletSpawnTime.start()
					canspawnbullet = false
			if Global.activepowerups["freeze"] == false:
				position.y = posy + sin(sin/10.0)
		if type == "creep":
			#angle += delta * speednm 
			dia -= delta/3
			$Sprite3D.modulate = Color(0.4,0,0,1)
			position.y = posy
		if type == "dodger":
			if oncursor[0] == false:
				oncursor[1] = 1
			if oncursor[0] == true:
				if oncursor[1] == 1:
					dir = dir * -1
					oncursor[1] = 0
				oncursor[0] = false
				
			else:#angle += delta * speed
				pass
			position.y = posy *(dia/dia1) + 0.5
			angle += delta * speed * dir
			dia -= delta/2
			$Sprite3D.modulate = Color(0,0,1,1)
	




		
	if dead == true:
		$GPUParticles3D.emitting = true
		if fallin == true:
			position.y -= 0.2
		if onetime == 0:
			if deathsound == 0:
				$AudioStreamPlayer.play()
			else:
				$AudioStreamPlayer2.play()
			onetime = 1

	#if dia > 0:
	#	dia -= delta
	$MeshInstance3D.position = position
	$MeshInstance3D.position.y = 0.2
	
	


func bullet_spawning():
	canspawnbullet = true
	var instance = bullet.instantiate()
	instance.position = position
	get_parent().get_parent().get_node("bullets").add_child(instance)
	
#go to x = (distance)sin(angle) and y = (distance)cos(angle)

func _on_bullet_spawn_time_timeout() -> void:
	bullet_spawning()
	$BulletSpawnTime.wait_time =  randf_range(0.7,1.3) * bullet_spawn_rate

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground"):
		if dead == true:
			set_collision_layer_value(1,false)
			$blood.show()
			fallin = false
			$GPUParticles3D.emitting = true
			$AnimationPlayer.play("die")
	if body.is_in_group("player"):
		var candamage = true
		if Global.activepowerups["invincibility"] == true:
			candamage = false
		if candamage == true:
			Global.health -= 1
		Global.hurt = true
		$GPUParticles3D.emitting = true
		$AnimationPlayer.play("die")

		if Global.activepowerups["shield"] == true:
			Global.health += 0.5
			return
		print("dum")
		
		
		

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
