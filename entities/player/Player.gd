extends KinematicBody2D


onready var navigation_system = $NavigationSystem
onready var nav_agent = $NavigationAgent2D

export var speed : float = 3.5


func _on_Player_input_event(_viewport, event, _shape_idx):
	"""When player is clicked, create new DestinationMarker instance.
	"""
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			print("PLAYER CLICKED: ", event)
			navigation_system.create_new_marker()



func _unhandled_input(event):
	if navigation_system.get_held_status():  # If the destination marker is being held
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.is_action_released("click"):
				# Mouse click released!
				navigation_system.place_marker()


func _on_NavigationAgent2D_target_reached():
	"""Function called when nav_agent reaches target
	"""
	# NOTE: Make sure to increase the PathDesiredDistance, TargetDesiredDistance and PathMaxDistance
	# values of the NavigationAgent2D to avoid jitter. See: https://github.com/godotengine/godot/issues/62532
	navigation_system.remove_marker()


func _physics_process(delta):

	if navigation_system.get_marker() and is_instance_valid(navigation_system.get_marker()) :
		nav_agent.set_target_location(navigation_system.get_marker().get_global_position())
		var distance_to_walk = speed * delta  # Walk distance for this frame,
		#product of soldiers speed and the time elapsed from the previous frame
		var next_location = nav_agent.get_next_location()
		
		# Calculate the path
		var path = nav_agent.get_nav_path()
		navigation_system.set_path(path)

		# Calculate the velocity.
		var vel = (next_location - global_position).normalized() * speed
		nav_agent.set_velocity(vel)

		global_position += vel
