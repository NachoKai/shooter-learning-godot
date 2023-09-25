extends Node

signal state_changed

var red: Color = Color(220, 20, 60, 1)
var yellow: Color = Color(255, 215, 0, 1)
var green: Color = Color(0, 128, 0, 1)
var blue: Color = Color(30, 144, 255, 1)

var max_bullets_amount: int = 100
var max_grenades_amount: int = 20
var max_player_health: int = 100

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
		player_health = value
		state_changed.emit()

var player_pos: Vector2
