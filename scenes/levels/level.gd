extends Node2D

var laserScene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenadeScene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_area_2d_body_entered(_body):
	print("body entered")


func _on_area_2d_body_exited(_body):
	print("body exited")


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


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
