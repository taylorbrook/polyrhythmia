extends AnimationPlayer

func _on_v_slider_value_changed(value):
	speed_scale = (value/30)
