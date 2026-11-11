extends Node

const end_height = -4260

var prog = 0
var playtime = 0
var game_ended = false

@onready var score_label: Label = $"../Player/Camera2D/CanvasLayer/Label"
var label_string = "none"

func set_prog(height: float):
	prog = snapped((height / end_height) * 100, 0)
	if (prog < 0): prog = 0
	if (prog >= 100): 
		prog = 100
		game_ended = true
	
	if (!game_ended): playtime += get_process_delta_time()
	
	if (label_string == "none"):
		score_label.text = "Progress: " + str(prog) + "%\nTime: " + str(round(playtime * 10) / 10) + "s"
	else:
		score_label.text = "Progress: " + label_string + "\nTime: " + str(round(playtime * 10) / 10) + "s"
	
func custom_message(msg: String):
	if (msg == "none"):
		label_string = "none"
	else:
		label_string = msg
