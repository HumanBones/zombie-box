extends Control

class_name HealthBar

signal update_prog_bar_ui

@export var min_value : float = 0.0
@export var max_value : float = 100.0

var cur_value : float

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	progress_bar.value = max_value
	
func set_min_value(amount : float) ->void:
	min_value = amount
	
func set_max_value(amount : float) ->void:
	max_value = amount

func set_value(amount : float) -> void:
	cur_value = amount
	update_ui(cur_value)
	
func update_ui(amount : float) ->void:
	progress_bar.value = amount
	update_prog_bar_ui.emit()
