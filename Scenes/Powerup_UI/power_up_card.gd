extends Control

class_name PowerUpCard

@export var power_up_data: PowerUp

@onready var title: Label = $MarginContainer/MarginContainer/VBoxContainer/Title
@onready var description: Label = $MarginContainer/MarginContainer/VBoxContainer/Description
@onready var button: Button = $MarginContainer/MarginContainer/VBoxContainer/Button
@onready var texture_rect: TextureRect = $MarginContainer/MarginContainer/VBoxContainer/TextureRect

func _ready() -> void:
	button.text = "Select"
	if power_up_data != null:
		title.text = power_up_data.name
		texture_rect.texture = power_up_data.texture
		description.text = power_up_data.decription + str(power_up_data.amount) + " %"

func _on_button_pressed() -> void:
	power_up_data.apply_powerup()
