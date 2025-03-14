extends Node2D
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if state == 0:
		$AnimationPlayer.play("select")
		$Button.hide()
		state = 1


func _on_exitbutton_pressed() -> void:
	if state == 1:
		$Button.show()
		$AnimationPlayer.play_backwards("select")
		state = 0




func _on_key_ok_pressed() -> void:
	Global.phoneinput[0] = 1


func _on_key_up_pressed() -> void:
	Global.phoneinput[1] = 1


func _on_key_down_pressed() -> void:
	Global.phoneinput[2] = 1


func _on_key_left_pressed() -> void:
	Global.phoneinput[3] = 1


func _on_key_right_pressed() -> void:
	Global.phoneinput[4] = 1
