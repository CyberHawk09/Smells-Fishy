extends Node

signal score_changed(new_score) # Define a custom signal

var score = 0

func add_score(amount: int):
	score += amount
	if score <= 0:
		score = 0
	score_changed.emit(score) # Tell everyone the score changed!
