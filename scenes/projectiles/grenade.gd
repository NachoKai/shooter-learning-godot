extends RigidBody2D

const SPEED: int = 2000


func explode():
	$AnimationPlayer.play("Explosion")
