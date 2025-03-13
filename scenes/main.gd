extends Node3D
var enemy = load("res://objects/enemy/enemy.tscn")
var types = ["normal","flying", "creep"]
# Called when the node enters the scene tree for the first time.

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
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		Global.hurt = false
		$ui/hurt/AnimationPlayer.play("hurt")
	
	if $enemies.get_child_count() <= 0:
		Global.health = 10
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
