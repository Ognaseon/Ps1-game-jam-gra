extends Node3D
var enemy = load("res://objects/enemy/enemy.tscn")
var types = ["normal","flying"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(100):
		var inst = enemy.instantiate()
		inst.type = types[randi_range(0,1)]
		$enemies.add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ui/Label.text = "score: " + str(Global.score)
	$ui/cursor.position = Global.mousepos - Vector2(12.5,12.5)

func deleteEnemy(enemyid):	
	if enemyid.dead == false:
		Global.score += 1
	for n in $enemies.get_children():
		if n == enemyid:
			n.dead = true
