extends Node

var mousepos = Vector2(0,0)
var score = 0
var health = 10
var hurt = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mousepos = get_viewport().get_mouse_position()
