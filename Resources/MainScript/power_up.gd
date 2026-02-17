extends Resource

class_name PowerUp

@export var index : int
@export var name : String
@export var decription : String
@export var amount : float
@export var texture : Texture2D


func apply_powerup() ->void:
	push_error("No powerup function " + name)
