extends Control

@export var power_up_card_scene : PackedScene
@export var power_up_array : Array[PowerUp]
@export var amount_of_upgrades = 3

@onready var card_container : HBoxContainer = $MarginContainer/HBoxContainer

var power_up_card_array : Array[PowerUpCard]

func _ready() -> void:
	SpawnManager.pick_upgrade.connect(show_upgrade)
	PowerUpManager.powerup_used.connect(hide_upgrade)

func show_upgrade() ->void:
	self.visible = true
	pick_card_upgrade()

func hide_upgrade() ->void:
	self.visible = false
	remove_power_up_cards()

func pick_card_upgrade() ->void:
	var power_up_upgrade : PowerUp
	var temp_array = power_up_array.duplicate()
	
	for i in amount_of_upgrades:
		power_up_upgrade = temp_array.pick_random()
		temp_array.erase(power_up_upgrade)
		add_powerup_card(power_up_upgrade)

func add_powerup_card(power_res : PowerUp) ->void:
	var power_up_card_scene_node = power_up_card_scene.instantiate() as MarginContainer
	power_up_card_scene_node.power_up_data = power_res
	card_container.call_deferred("add_child",power_up_card_scene_node)
	power_up_card_array.append(power_up_card_scene_node)

func remove_power_up_cards() ->void:
	if power_up_array.is_empty():
		return
	for power_up in power_up_card_array:
		power_up.call_deferred("queue_free")
		
	power_up_card_array.clear()
