extends Area3D
var angle = 90
var speed = 0.05
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += speed*sin(angle)
	position.z += speed*cos(angle)
	angle += delta

#go to x = (distance)sin(angle) and y = (distance)cos(angle)
