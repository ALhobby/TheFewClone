extends Area2D

class_name DestinationMarker

signal marker_clicked

onready var animation_player = $AnimationPlayer
onready var line = $Line2D


func _ready():
	set_as_toplevel(true)  # This makes it independent from its parents transformations, IMPORTANT!
	line.set_as_toplevel(true)


func _on_DestinationMarker_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			print("MARKER CLICKED: ", event)
			emit_signal("marker_clicked")


func draw_line_to_marker(path_to_draw):
	line.points = path_to_draw
