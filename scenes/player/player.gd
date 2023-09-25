extends CharacterBody2D

signal laser(pos, dir)
signal grenade(pos, dir)

@export var max_speed: int = 800
var canLaser: bool = true
var canGranade: bool = true
var speed: int = max_speed

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	look_at(get_global_mouse_position())
	Globals.player_pos = global_position

	var playerDirection = (get_global_mouse_position() - position).normalized()

	if Input.is_action_pressed("primary") and canLaser and Globals.bullets_amount > 0:
		Globals.bullets_amount -= 1
		$ShootParticles.emitting = true
		var laserMarkers = $LaserStartPositions.get_children()
		var selectedLaser = laserMarkers[randi() % laserMarkers.size()]
		var laserPosition = selectedLaser.global_position
		canLaser = false
		$ShootTimer.start()
		laser.emit(laserPosition, playerDirection)

	if Input.is_action_pressed("secondary") and canGranade and Globals.grenades_amount > 0:
		Globals.grenades_amount -= 1
		var grenadeMarkers = $GrenadeStartPositions.get_children()
		var selectedGrenade = grenadeMarkers[randi() % grenadeMarkers.size()]
		var grenadePosition = selectedGrenade.global_position
		canGranade = false
		$GrenadeTimer.start()
		grenade.emit(grenadePosition, playerDirection)

func _on_shoot_timer_timeout():
	canLaser = true

func _on_grenade_timer_timeout():
	canGranade = true
