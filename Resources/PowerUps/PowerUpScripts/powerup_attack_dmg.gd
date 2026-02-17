extends PowerUp

class_name AttackDMGPowerUp

func apply_powerup() ->void:
	PowerUpManager.player_upgrade_manager.set_bullet_dmg(amount/100)
	PowerUpManager.power_up_list.append(self)
	PowerUpManager.powerup_used.emit(self)
