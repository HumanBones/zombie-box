extends State

class_name EnemyStart

@onready var timer: Timer = $Timer


func enter() ->void:
	timer.start()

func _on_timer_timeout() -> void:
	transitioned.emit(self,"follow")
