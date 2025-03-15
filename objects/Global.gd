extends Node
var damaged = 0
var powerupstaken = 0
var time = 0
var mousepos = Vector2(0,0)
var score = 0
var health = 10
var difficulty = 'easy'
var hurt = false
var wave =1
var camrot = 0
var phoneinput = [0,0,0,0,0]
var powerups = []
var maxhealth = 10
var activepowerups = {"slowdown":false,"freeze":false,"shield":false,"invincibility":false,
"scary": false, "reflection": false, "laser": true, "megashot": false}


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for i in activepowerups.keys():
		print(i)
		activepowerups[i] = false
	mousepos = get_viewport().get_mouse_position()
	for i in range(powerups.size()):
		powerups[i][1] -= delta

		activepowerups[powerups[i][0]] = true
		if powerups[i][1] < 0:
			if powerups[i][0] == "hpup":
				maxhealth +=1

			if powerups[i][0] == "life":
				health +=1
			powerups.remove_at(i)
			return
