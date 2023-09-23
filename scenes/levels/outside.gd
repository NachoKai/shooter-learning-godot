extends LevelParent

func _on_gate_gate_area():
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,1)
