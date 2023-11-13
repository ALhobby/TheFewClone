extends Node2D


onready var destination_marker = load("res://entities/player/DestinationMarker.tscn")

var is_held : bool = false setget set_held_status, get_held_status
var marker : DestinationMarker = null
var path = null


func create_new_marker():
	"""Create new instance of the destination marker.
	If one existed beforehand, delete it.
	"""
	if marker:  # If a marker exists already, remove it
		remove_child(marker)
	marker = destination_marker.instance()  # Create a new Destination Marker.
	marker.connect("marker_clicked", self, "pick_up_marker")  # Connect "marker_clicked" signal
	add_child(marker)  # Add it as a child of this node.
	is_held = true
	return marker


func remove_marker():
	if marker and not is_held:
		remove_child(marker)
		marker.queue_free()


func place_marker():
	"""Place a marker that was being dragged. Play bouncing animation.
	"""
	is_held = false
	marker.animation_player.play("Bounce")


func pick_up_marker() -> void:
	is_held = true
	marker.animation_player.stop()


func get_marker() -> DestinationMarker:
	return marker


func get_held_status() -> bool:
	return is_held


func set_held_status(new_status : bool):
	is_held = new_status


func set_path(new_path) -> void:
	path = new_path


func _process(delta):
	if is_held:  # Update DestinationMarker position as it is dragged
		marker.global_position = lerp(marker.global_position, get_global_mouse_position(), 25*delta)
		marker.draw_line_to_marker(path)
