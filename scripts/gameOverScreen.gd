extends CanvasLayer

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_try_again_button_pressed():
	get_tree().reload_current_scene()

func _on_try_again_button_mouse_entered():
	Sound.ui_hover()

func _on_main_menu_button_mouse_entered():
	Sound.ui_hover()
