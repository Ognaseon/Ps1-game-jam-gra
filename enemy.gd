extends Area3D
var angle = 0
var dia = 20
var progress = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x = dia * sin(angle )
	position.z = dia * cos(angle)
	angle += delta * 0.5

#go to x = (distance)sin(angle) and y = (distance)cos(angle)
