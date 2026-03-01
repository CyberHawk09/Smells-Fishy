extends Node2D

@export var fish_table = [
	{ "scene": preload("res://pufferfish.tscn"), "weight" : 30},
	{ "scene": preload("res://jellyfish.tscn"), "weight" : 20},
	{ "scene": preload("res://starfish.tscn"), "weight" : 20},
	{ "scene": preload("res://fish.tscn"), "weight" : 20},
	{ "scene": preload("res://anglerfish.tscn"), "weight" : 10}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		for i in range(40):
			spawn_fish(i * 200 + 600)
		var dolphin = preload("res://dolphin.tscn")
		var dolphinA = dolphin.instantiate()
		var dolphinB = dolphin.instantiate()
		add_child(dolphinA)
		add_child(dolphinB)

func pick_weighted_fish(table):
	var r := randf() * 100
	var cumulative := 0.0
	for fish in table:
		cumulative += fish.weight
		if r <= cumulative:
			return fish.scene
	return table[0].scene

func spawn_fish(y) :
	var fish_scene = pick_weighted_fish(fish_table)
	var fish_instance = fish_scene.instantiate()
	var view_size = get_viewport_rect().size
	fish_instance.global_position = Vector2(
		randf_range(view_size.x/-2, view_size.x/2),
		y
	)
	add_child(fish_instance)
