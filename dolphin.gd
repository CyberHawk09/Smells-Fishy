extends Area2D

@export var velocity = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("dolphins")
	global_position.x = randf_range(-500, 500)
	global_position.y = randf_range(15000, 25000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.y -= velocity * delta
	if global_position.y <= -200:
		queue_free()
