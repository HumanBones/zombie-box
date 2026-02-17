extends Node

signal powerup_used(powerup:PowerUp)

var power_up_list : Array[PowerUp]
var player : Player
var player_upgrade_manager : PlayerUpgradeManager


func _ready() -> void:
	player = GameStateManager.player
	player_upgrade_manager = get_tree().get_first_node_in_group("PlayerUpgradeManager")
	powerup_used.connect(power_up_used)

func power_up_used(powerup:PowerUp) ->void:
	print("Powerup: " + powerup.name)
