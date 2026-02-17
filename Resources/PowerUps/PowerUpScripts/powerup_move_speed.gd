extends PowerUp

class_name MoveSpeedPowerUp

func apply_powerup() ->void:
	PowerUpManager.player_upgrade_manager.set_speed(amount/100)
	PowerUpManager.power_up_list.append(self)
	PowerUpManager.powerup_used.emit(self)
