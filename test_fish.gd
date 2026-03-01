extends Area2D

var caught = false
var hook : Area2D
var drag = randf_range(0.01, 0.09)

# --- NEW SWIM VARIABLES ---
var swim_speed = randf_range(50.0, 150.0) # Speed of the fish
var swim_range = randf_range(-400.0, 400.0) # How far it swims before turning
var time_passed = randf_range(0.0, 5.0) # Offset so all fish don't move in sync
@onready var start_x = global_position.x # Remember where we started

func _process(delta: float) -> void:
	if caught:
		check_drag()
	else:
		swim_back_and_forth(delta)

func swim_back_and_forth(delta: float):
	time_passed += delta
	
	# Calculate the offset using a Sine wave
	# sin(time) gives a value between -1 and 1
	var offset = sin(time_passed * (swim_speed / 100.0)) * swim_range
	
	# Update position
	global_position.x = start_x + offset
	
	# Flip the sprite to face the direction it's swimming
	if cos(time_passed * (swim_speed / 100.0)) > 0:
		scale.x = abs(scale.x) # Facing right (assuming sprite faces right)
	else:
		scale.x = -abs(scale.x) # Facing left

func _on_area_entered(area: Area2D):
	print("Collided with: ", area.name)
	# You can filter by group, class, or name
	if area.name == "Hook":
		print("fish entered the area!")
		caught = true
		hook = area

func check_drag():
	# Calculate a point slightly behind the hook (e.g., 50 pixels above/behind)
	var target_pos = hook.global_position + Vector2(0, 50)
	
	# Move the fish towards that target position smoothly
	# 0.1 is the weight; higher = stiffer line, lower = more "drag"
	global_position = global_position.lerp(target_pos, drag)
	
	# Optional: Make the fish face the hook
	look_at(hook.global_position)
	if global_position.y < 150:
		queue_free()
		GameManager.add_score(10)
	
