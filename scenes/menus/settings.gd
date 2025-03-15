extends Control

#slaby kod

func _on_easy_pressed() -> void:
	Global.difficulty = 'easy'
	hide()
	get_parent().get_child(0).show()


func _on_medium_pressed() -> void:
	Global.difficulty = 'medium'
	hide()
	get_parent().get_child(0).show()


func _on_hard_pressed() -> void:
	Global.difficulty = 'hard'
	hide()
	get_parent().get_child(0).show()
