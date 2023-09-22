extends Area2D

const SPEED: int = 3000
var direction: Vector2 = Vector2.UP

func _process(delta):
	position += direction * SPEED * delta
