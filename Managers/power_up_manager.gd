extends Node

signal powerup_used

var power_up_list : Array[PowerUp]
var player : Player
var player_upgrade_manager : PlayerUpgradeManager


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	player_upgrade_manager = get_tree().get_first_node_in_group("PlayerUpgradeManager")
	powerup_used.connect(power_up_used)

func add_powerup(powerup:PowerUp) -> void:
	if powerup != null:
		
		match powerup.index:
			"bullet_size":
				player_upgrade_manager.set_bullet_size(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"bullet_speed":
				player_upgrade_manager.set_bullet_speed(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"bullet_dmg":
				player_upgrade_manager.set_bullet_dmg(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"attack_speed":
				player_upgrade_manager.set_attack_speed(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"hp_up":
				player_upgrade_manager.set_hp(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"attack_range":
				player_upgrade_manager.set_attack_range(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()
			"move_speed":
				player_upgrade_manager.set_speed(powerup.amount/100)
				power_up_list.append(powerup)
				powerup_used.emit()

func power_up_used() ->void:
	print(power_up_list)
