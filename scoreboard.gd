extends Label

func _ready() -> void:
	# Connect to the global signal
	GameManager.score_changed.connect(_on_score_changed)
	# Initial text set
	_on_score_changed(GameManager.score)

func _on_score_changed(new_score: int) -> void:
	text = "Score: " + str(new_score)
