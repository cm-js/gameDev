extends Node

var prog = 0

@onready var score_label: Label = $"../Player/Camera2D/CanvasLayer/Label"

func set_prog(height: float):
	prog = round((height / -4260) * 1000) / 10
	if (prog < 0): prog = 0.0
	if (prog > 100): prog = 100.0
	score_label.text = "Progress: " + str(prog) + "%"
