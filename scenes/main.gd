extends Node3D
var enemy = load("res://objects/enemy/enemy.tscn")
var types = ["normal","flying", "creep"]
# Called when the node enters the scene tree for the first time.

func genenemies(normalcount, flyingcount, creepcount):
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

func _ready() -> void:
	$ui/wave/AnimationPlayer.play("wave")
	genenemies(10,3,7)
	


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
		$ui/wave/AnimationPlayer.play("wave")
		genenemies(10+10*Global.wave,3+5*Global.wave,7+8*Global.wave)

func deleteEnemy(enemyid):	
	if enemyid.dead == false:
		Global.score += 1
	for n in $enemies.get_children():
		if n == enemyid:
			n.dead = true
