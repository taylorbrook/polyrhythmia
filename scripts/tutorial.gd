extends Node2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/3d_test.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://rhythms/audioreactivetexture.tscn")
