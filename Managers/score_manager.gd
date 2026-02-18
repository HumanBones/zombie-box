extends Node

signal score_updated(amount)
signal new_high_score(amount)


var cur_score : int = 0
var high_score : int

func update_score(amount: int) ->void:
	cur_score += amount
	if cur_score > high_score:
		high_score = cur_score
		new_high_score.emit(high_score)
	score_updated.emit(cur_score)

func reset_score() ->void:
	cur_score = 0
