extends Node

signal state_changed

var red: Color = Color(0.862745, 0.0784314, 0.235294, 1)
var yellow: Color = Color(0.933333, 0.909804, 0.666667, 1)
var green: Color = Color(0.486275, 0.988235, 0, 1)
var blue: Color = Color(0.117647, 0.564706, 1, 1)

var max_bullets_amount: int = 100
var max_grenades_amount: int = 20
var max_player_health: int = 100
var player_vulnerable: bool = true

var bullets_amount = 100:
	set(value):
		bullets_amount = value
		state_changed.emit()

var grenades_amount = 20:
	set(value):
		grenades_amount = value
		state_changed.emit()

var player_health = 100:
	set(value):
		if value > player_health:
			player_health = min(value, max_player_health)
		else:
			if player_vulnerable:
				player_health = value
				player_vulnerable = false
				player_invulnerable_timer()
		state_changed.emit()

var player_position: Vector2

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
