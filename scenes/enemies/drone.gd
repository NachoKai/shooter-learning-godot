extends CharacterBody2D

const SPEED = 400

func _process(_delta):
	var direction = Vector2.UP
	velocity = direction * SPEED
	move_and_slide()
