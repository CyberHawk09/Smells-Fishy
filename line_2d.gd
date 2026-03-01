extends Line2D

@export var area_node: Area2D
@export var target_node: Node2D
'''
func _ready2():
	queue_redraw()
func _process(_delta):
	if area_node and target_node:
		# Update points to match the global positions of the nodes
		points[0] = to_local(area_node.global_position)
		points[1] = to_local(target_node.global_position)
'''
func _ready():
	# Pre-create the two points so they exist at index 0 and 1
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)

func _process(_delta):
	# Now that the points exist, you can set them safely
	set_point_position(0, to_local(area_node.global_position))
	set_point_position(1, to_local(target_node.global_position))
