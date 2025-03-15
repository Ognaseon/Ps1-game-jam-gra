extends Control



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_pressed() -> void:
	hide()
	get_parent().get_child(1).show()


func _on_exit_pressed() -> void:
	get_tree().quit()
