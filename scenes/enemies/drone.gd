extends CharacterBody2D

var max_speed: int = 650
var speed: int = 50
var active: bool = false
var vulnerable: bool = true
var health: int = 50
var explosion_active: bool = false
var explosion_radius: int = 400

func _ready():
	$Explosion.hide()
	$DroneImage.show()

func _process(delta):
	if active:
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		look_at(Globals.player_position)
		var collision = move_and_collide(velocity * delta)
		if collision:
			$Explosion/AnimationPlayer.play("explosion")
			explosion_active= true
	if explosion_active:
		var itemGroupNodes = get_tree().get_nodes_in_group("ItemGroup")
		var damageableGroupNodes = get_tree().get_nodes_in_group("DamageableGroup")
		var targets = itemGroupNodes + damageableGroupNodes
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
	$DroneImage.material.set_shader_parameter("progress", 1)
	if health <= 0:
		speed = 10
		$Explosion/AnimationPlayer.play("explosion")
		explosion_active= true


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 4)


func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress", 0)
