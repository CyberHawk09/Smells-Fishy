extends Node2D

func _draw():
	draw_line(Vector2($"../Hook".global_position.x, $"../Hook".global_position.y), Vector2(98, -283), Color.BLACK, 3.0)

func _process(_delta):
	queue_redraw()
