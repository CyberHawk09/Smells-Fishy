extends Node2D

var cast = false
var down = true
var returning = false
var velocity = 0.0
var cast_num = 0
var cast_max = 3
@onready var text = $Casts

@export var max_speed_down = 3000.0
@export var max_speed_up = 600.0
@export var accel_roc = 1200.0
@export var target_depth = 8000.0
@export var start_depth = 00.0 # Where the hook returns to

func _process(delta: float) -> void:
	text.text = str(cast_max - cast_num) + " casts remaining"
	if cast_num == 0:
		text.text += "(Press space to cast)"
	elif cast_max - cast_num <= 0:
		text.text += " (Press space to continue)"
	if !cast && Input.is_action_just_pressed("ui_accept"):
		cast = true
		down = true
		returning = false
		cast_num += 1
		if cast_num > cast_max:
			get_tree().change_scene_to_file("res://end.tscn")

	if cast:
		move_hook(delta)

'''
func move_hook2(delta: float):
	var hook = $"../Hook"
	
	if down:
		# Use move_toward on the GLOBAL Y directly
		hook.global_position.y = move_toward(hook.global_position.y, target_depth, max_speed * delta)
		
		# Log the actual value to the console to see if it's "stuck"
		print("Current Hook Y: ", hook.global_position.y)
		
		if hook.global_position.y >= target_depth:
			down = false
			returning = true
'''

func move_hook(delta: float):
	var hook = $"../Hook" # Using your working path
	var current_y = hook.global_position.y

	if down:
		# --- GOING DOWN ---
		var distance_to_bottom = target_depth - current_y
		
		# Brake when within 150 pixels of the bottom
		if distance_to_bottom > 150:
			velocity = move_toward(velocity, max_speed_down, accel_roc * delta)
		else:
			velocity = move_toward(velocity, 100, accel_roc * delta) # Slow crawl at end
			
		hook.global_position.y += velocity * delta
		
		if distance_to_bottom <= 2.0:
			velocity = 0
			down = false
			returning = true # Start the trip back up!

	elif returning:
		# --- COMING UP ---
		var distance_to_top = current_y - start_depth
		
		# Move upward (negative Y)
		velocity = move_toward(velocity, max_speed_up, accel_roc * delta)
		hook.global_position.y -= velocity * delta
		
		if distance_to_top <= 2.0:
			hook.global_position.y = start_depth
			cast = false # Reset for next cast
			velocity = 0
