extends Node

var prog = 0

@onready var score_label: Label = $"../Player/Camera2D/CanvasLayer/Label"

func set_prog(height: float):
	prog = snapped((height / -4260) * 100, 0)
	if (prog < 0): prog = 0
	if (prog > 100): prog = 100
	score_label.text = "Progress: " + str(prog) + "%"
