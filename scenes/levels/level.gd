extends Node2D
class_name LevelParent

var laserScene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenadeScene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var itemScene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	$UI.updateBulletsText()
	$UI.updateGrenadesText()
	$UI.updatePlayerHealthProgress()

	var itemContainer = get_tree().get_nodes_in_group("ItemGroup")
	for container in itemContainer:
		container.connect("open", _on_item_container_opened)

	for scout in get_tree().get_nodes_in_group("ScoutsGroup"):
		scout.connect("laser", _on_scout_laser)


func _on_item_container_opened(pos, dir):
	var item = itemScene.instantiate()
	item.position = pos
	item.direction = dir
	$Items.call_deferred("add_child", item)


func create_laser(pos, dir):
	var laser = laserScene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)


func _on_player_laser(pos, dir):
	create_laser(pos, dir)


func _on_scout_laser(pos, dir):
	create_laser(pos, dir)


func create_grenades(pos, dir):
	var grenade = grenadeScene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.SPEED
	$Projectiles.add_child(grenade)


func _on_player_grenade(pos, dir):
	create_grenades(pos, dir)


