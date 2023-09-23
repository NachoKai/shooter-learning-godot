extends StaticBody2D

signal gateArea


func _on_gate_area_body_entered(_body):
	gateArea.emit()
