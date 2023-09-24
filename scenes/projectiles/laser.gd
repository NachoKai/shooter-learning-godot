extends Area2D

@export var SPEED: int = 3000
var direction: Vector2 = Vector2.UP

func _ready():
	$LaserDestroyedTimer.start()

func _process(delta):
	position += direction * SPEED * delta

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()

func _on_laser_destroyed_timer_timeout():
	queue_free()
