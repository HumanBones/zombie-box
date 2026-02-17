extends Node2D

class_name PlayerUpgradeManager

@export var player: Player
@export var bullet_shooter: BulletShooter

signal upgraded(stat: String, amount : float)

func set_attack_speed(amount: float) ->void:
	bullet_shooter.attack_speed += bullet_shooter.attack_speed * amount
	upgraded.emit()
	
func set_attack_range(amount: float) ->void:
	player.attack_range += player.attack_range * amount
	upgraded.emit()

func set_speed(amount: float) ->void:
	player.speed += player.speed * amount
	upgraded.emit()
	
func set_hp(amount: float) ->void:
	player.hp += player.max_hp * amount
	player.max_hp += player.max_hp * amount
	player.healthbar.set_max_value(player.max_hp)
	player.healthbar.update_min_max_value()
	player.healthbar.set_value(player.hp)
	upgraded.emit()

func set_bullet_size(amount: float) ->void:
	bullet_shooter.bullet_size += bullet_shooter.bullet_size * amount
	upgraded.emit()

func set_bullet_dmg(amount: float) ->void:
	bullet_shooter.bullet_dmg += bullet_shooter.bullet_dmg * amount
	upgraded.emit()
	
func set_bullet_speed(amount: float) ->void:
	bullet_shooter.bullet_speed += bullet_shooter.bullet_speed * amount
	upgraded.emit()
