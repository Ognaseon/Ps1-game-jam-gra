extends Control
var bselected = 0
var apps= [0,1,2,3]
var app = "menu"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# TELEFON UI APKI SELECT LOGIKA JAKBY CO
	
	for n in get_children():
		n.hide()
	if app == "start":
		$startscreen.show()
	if app == "menu":
		$mainscreen.show()
	if app == "internet":
		$internet.show()
	for n in $mainscreen/buttons.get_children():
		n.get_child(0).hide()
	
	for i in range($mainscreen/buttons.get_child_count()):
		if i == bselected:
			$mainscreen/buttons.get_child(i).get_child(0).show()
	
	
	if app == "menu":
		if Global.phoneinput[0] == 1:
			pass
		if Global.phoneinput[1] == 1:
			if bselected != 0:
				if bselected != 1:
					bselected -= 2
		if Global.phoneinput[2] == 1:
			if bselected != 3:
				if bselected != 2:
					bselected += 2
		if Global.phoneinput[3] == 1:
			if bselected != 0:
				bselected -= 1
		if Global.phoneinput[4] == 1:
			if bselected != 3:
				bselected += 1
	
	
	
		if Global.phoneinput[0] == 1:
			if bselected == 0:
				pass
			if bselected == 1:
				$Control/AudioStreamPlayer.play()
			if bselected == 2:
				pass
			if bselected == 3:
				app = "internet"
				Global.phoneinput[0] = 0
			
	if app == "internet":
		if Global.phoneinput[0] == 1:
			app = "menu"
	
	Global.phoneinput = [0,0,0,0,0]


func _on_audio_stream_player_finished() -> void:
	$Control/AudioStreamPlayer.play()
