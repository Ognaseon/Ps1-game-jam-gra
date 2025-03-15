extends Node3D
var enemy = load("res://objects/enemy/enemy.tscn")
var powerup = load("res://objects/powerup/powerup.tscn")
var types = ["normal","flying", "creep", "dodger"]

var can_shield = true
# Called when the node enters the scene tree for the first time.
func spawnpowerup():
	var inst = powerup.instantiate()
	$powerup.add_child(inst)
func genenemies(normalcount, flyingcount, creepcount, dodgecount):
	for i in range(normalcount):
		var inst = enemy.instantiate()
		inst.type = "normal"
		$enemies.add_child(inst)
	for i in range(flyingcount):
		var inst = enemy.instantiate()
		inst.type = "flying"
		$enemies.add_child(inst)
	for i in range(creepcount):
		var inst = enemy.instantiate()
		inst.type = "creep"
		$enemies.add_child(inst)
	for i in range(dodgecount):
		var inst = enemy.instantiate()
		inst.type = "dodger"
		$enemies.add_child(inst)

func _ready() -> void:
	$ui/wave/AnimationPlayer.play("wave")
	genenemies(10,0,0,0)
	genenemies(20,10,0,0)
	
func status_effects_look():
	if Global.activepowerups["megashot"] == true:
		var tween_m = create_tween()
		tween_m.set_parallel(true)
		tween_m.tween_property($ui/cursor/TextureRect, 'size', Vector2(50, 50), 1)
		tween_m.tween_property($ui/cursor/TextureRect, 'position', Vector2(-12.5, -12.5), 1)
	else:
		var tween_m = create_tween()
		tween_m.set_parallel(true)
		tween_m.tween_property($ui/cursor/TextureRect, 'size', Vector2(25, 25), 1)
		tween_m.tween_property($ui/cursor/TextureRect, 'position', Vector2(0, 0), 1)
		#$ui/cursor/TextureRect.position = Vector2(-12.5, -12.5)
	if Global.activepowerups["shield"] == true and can_shield:
		$ui/AnimationPlayer.play("im_god")
		can_shield = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	status_effects_look()
	Global.time += delta
	$ui/lives.max_value = Global.maxhealth
	$ui/lives.value = Global.health
	$ui/Label.text = "score: " + str(Global.score)
	$ui/cursor.position = Global.mousepos - Vector2(12.5,12.5)
	if $ui/cursor.position.x < 20:
		Global.camrot +=delta * abs($ui/cursor.position.x-20) / 20
	if $ui/cursor.position.x > 600:
		Global.camrot -=delta * abs($ui/cursor.position.x-600) / 20
	if Global.health < 1:
		$ui/deathscreen.show()
	if Global.hurt == true:
		$damage.play()
		Global.hurt = false
		$ui/hurt/AnimationPlayer.play("hurt")
	
	if $enemies.get_child_count() <= 0:
		Global.health = Global.maxhealth
		Global.wave += 1
		$ui/wave.text = "WAVE " + str(Global.wave)
		if Global.wave == 10:
			$ui/wave.text = "FINAL WAVE"
		$ui/wave/AnimationPlayer.play("wave")
		match Global.wave:
			2:
				#genenemies(10+5*Global.wave,3+3*Global.wave,7+4*Global.wave)
				genenemies(20,0,5,0)
			3:
				genenemies(30,0,10,0)
			4:
				genenemies(20,5,15,0)
			5:
				genenemies(30,10,20,0)
			6:
				genenemies(40,15,25,0)
			7:
				genenemies(20,0,10,10)
			8:
				genenemies(20,0,10,20)
			9:
				genenemies(20,0,10,30)
			10:
				genenemies(20,0,10,40)

func deleteEnemy(enemyid):
	if enemyid.dead == false:
		Global.score += 1
	for n in $enemies.get_children():
		if n == enemyid:
			n.dead = true

func deleteBullet(bulletid):
	print("del", str(bulletid))
	for n in $bullets.get_children():
		if n == bulletid:
			n.scale.x = 50
			n.queue_free()

func _on_poweruptimer_timeout() -> void:
	can_shield = true
	$poweruptimer.wait_time = 1# randi_range(10,20)
	spawnpowerup()
