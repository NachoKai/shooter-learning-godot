extends Node2D
class_name LevelParent

var laserScene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenadeScene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	$UI.updateBulletsText()
	$UI.updateGrenadesText()
	$UI.updatePlayerHealthProgress()
	
	var itemContainer = get_tree().get_nodes_in_group("ItemContainer")
	for container in itemContainer:
		container.connect("open", _on_item_container_opened)
		
		
func _on_item_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	$Items.call_deferred("add_child", item)


func _on_player_laser(pos, dir):
	var laser = laserScene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)


func _on_player_grenade(pos, dir):
	var grenade = grenadeScene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.SPEED
	$Projectiles.add_child(grenade)

