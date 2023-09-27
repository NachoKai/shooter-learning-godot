extends CharacterBody2D

signal laser(pos, dir)

var health: int = 50
var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true
var vulnerable: bool = true

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var dir: Vector2 = (Globals.player_pos - pos).normalized()
			laser.emit(pos, dir)
			can_laser = false
			$Timers/LaserTimer.start()


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/DamageTimer.start()
		$ScoutImage.material.set_shader_parameter("progress", 1)
		if health <= 0:
			queue_free()


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_timer_timeout():
	can_laser = true


func _on_damage_timer_timeout():
	vulnerable = true
	$ScoutImage.material.set_shader_parameter("progress", 0)
