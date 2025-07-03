extends Node2D

class_name PlayerUpgradeManager

@export var player : Player
@export var bullet_shooter : BulletShooter

signal upgradeded

func set_attack_speed(amount : float) ->void:
	player.attack_speed += player.attack_speed * amount
	upgradeded.emit()
	
func set_attack_range(amount : float) ->void:
	player.attack_range += player.attack_range * amount
	upgradeded.emit()

func set_speed(amount : float) ->void:
	player.speed += player.speed * amount
	upgradeded.emit()
	
func set_hp(amount : float) ->void:
	player.hp = player.hp * amount
	upgradeded.emit()

func set_bullet_size(amount : float) ->void:
	bullet_shooter.bullet_size += bullet_shooter.bullet_size * amount
	upgradeded.emit()

func set_bullet_dmg(amount : float) ->void:
	bullet_shooter.bullet_dmg += bullet_shooter.bullet_dmg * amount
	upgradeded.emit()
	
func set_bullet_speed(amount : float) ->void:
	bullet_shooter.bullet_speed += bullet_shooter.bullet_speed * amount
	upgradeded.emit()
