extends Area2D
@export var speed = 800
var caught_count = 0
@export var max_fish = 3  # Set your limit here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if $"../Fisher".returning:
		set_collision_mask_value(2, true)
		set_collision_layer_value(2, true)
		set_collision_mask_value(1, false)
		set_collision_layer_value(1, false)
		
	else:
		set_collision_mask_value(1, true)
		set_collision_layer_value(1, true)
		set_collision_mask_value(2, false)
		set_collision_layer_value(2, false)
		
	var direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	
	# Get the viewport size
	var view_size = get_viewport_rect().size
	
	# Clamp position, optionally factoring in collision shape size
	position.x = clamp(position.x, view_size.x/-2, view_size.x/2)
	#position.y = clamp(position.y, view_size.y/-2, view_size.y/2)
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	position += direction * speed * delta
	#print(position.y)
