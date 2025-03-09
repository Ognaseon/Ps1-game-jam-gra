extends Area3D
var angle = randf_range(0,360)
var dia = randf_range(15,20)
var speed = randf_range(0.1,0.5)
var posy = 0
var sin = 0

@onready var bullet_spawn_rate = 10
@onready var bullet = preload('res://objects/enemy_bullet/bullet.tscn')
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	posy = position.y
	$BulletSpawnTime.wait_time = randf() * bullet_spawn_rate
	$BulletSpawnTime.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x = dia * sin(angle )
	position.z = dia * cos(angle)
	#angle += delta * speed
	#sin += 1.0
	position.y = posy + sin(sin/10.0)


func bullet_spawning():
	var instance = bullet.instantiate()
	$bullets.add_child(instance)
	
#go to x = (distance)sin(angle) and y = (distance)cos(angle)

func _on_bullet_spawn_time_timeout() -> void:
		bullet_spawning()
		$BulletSpawnTime.wait_time = randf() * bullet_spawn_rate
