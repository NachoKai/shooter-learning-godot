extends Node

signal state_changed

var red: Color = Color(0.862745, 0.0784314, 0.235294, 1)
var yellow: Color = Color(0.933333, 0.909804, 0.666667, 1)
var green: Color = Color(0.486275, 0.988235, 0, 1)
var blue: Color = Color(0.117647, 0.564706, 1, 1)

var max_bullets_amount: int = 100
var max_grenades_amount: int = 20
var max_player_health: int = 100

var bullets_amount = 10:
	set(value):
		bullets_amount = value
		state_changed.emit()

var grenades_amount = 20:
	set(value):
		grenades_amount = value
		state_changed.emit()

var player_health = 100:
	set(value):
		player_health = value
		state_changed.emit()

var player_pos: Vector2
