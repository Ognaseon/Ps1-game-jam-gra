extends Control
var bselected = 0
var apps= [0,1,2,3]
var app = "menu"
var music = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$stats/labels/time.text = str("time: ", floor(Global.time*10)/10)
	$stats/labels/score.text = str("score: ",Global.score)
	$stats/labels/damaged.text = str("damaged: ",Global.damaged)
	$stats/labels/powerups.text = str("powerups: ",Global.powerupstaken)
	# TELEFON UI APKI SELECT LOGIKA JAKBY CO
	$mainscreen/Panel/ProgressBar.value = Global.health
	$mainscreen/Panel/ProgressBar.max_value = Global.maxhealth
	for n in get_children():
		n.hide()
	if app == "start":
		$startscreen.show()
	if app == "menu":
		$mainscreen.show()
	if app == "internet":
		$internet.show()
	if app == "stats":
		$stats.show()
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
				if music == 0:
					$Control/AudioStreamPlayer.play()
					music = 1
					$mainscreen/buttons/Panel2/mdisabled.hide()
				if music == 2:
					$Control/AudioStreamPlayer.stop()
					$mainscreen/buttons/Panel2/mdisabled.show()
					music=0
				if music == 1:
					music = 2
			if bselected == 2:
				app = "stats"
				Global.phoneinput[0] = 0
			if bselected == 3:
				app = "internet"
				Global.phoneinput[0] = 0
			
	if app == "internet":
		if Global.phoneinput[0] == 1:
			app = "menu"
	if app == "stats":
		if Global.phoneinput[0] == 1:
			app = "menu"
	
	Global.phoneinput = [0,0,0,0,0]


func _on_audio_stream_player_finished() -> void:
	$Control/AudioStreamPlayer.play()
