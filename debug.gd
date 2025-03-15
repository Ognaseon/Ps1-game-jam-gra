extends Label

func _process(delta: float) -> void:
	text = str(Global.activepowerups) + '\n' + str(Global.powerups)
