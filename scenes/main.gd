extends Node3D
var enemy = load("res://objects/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(50):
		var inst = enemy.instantiate()
		inst.position.y = randf_range(1,12)
		$enemies.add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ui/Label.text = "score: " + str(Global.score)

func deleteEnemy(enemyid):
	Global.score += 1
	for n in $enemies.get_children():
		if n == enemyid:
			n.queue_free()
