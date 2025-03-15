extends Node3D
var dia = 20
var angle = randi_range(0,360)
var type = "powerup" + str(randi_range(1,10))
var ded = false
var data = {
	"powerup1": ["life", 0],
	"powerup2": ["hpup", 0],
	"powerup3": ["slowdown", 20],
	"powerup4": ["freeze", 8],
	"powerup5": ["shield", 20],
	"powerup6": ["invincibility", 8],
	"powerup7": ["scary", 15],
	"powerup8": ["reflection",1],
	"powerup9": ["laser", 5],
	"powerup10": ["megashot",10]
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	position.x = dia * sin(angle)
	position.z = dia * cos(angle)
	position.y = randi_range(1,5)
	$Label3D.text = data[type][0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	position.x = dia * sin(angle)
	position.z = dia * cos(angle)
	


func _on_powerupdespawn_timeout() -> void:
	queue_free()
