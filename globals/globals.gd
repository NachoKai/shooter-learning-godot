extends Node

signal state_changed

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
