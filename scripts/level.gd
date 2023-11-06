extends Node3D

func _ready():
	$MainCam/Camera3D/AnimationPlayer.play("running")
	$SongPlayer.play("Song1")
	#$"2_subdivisions".animation = $SongPlayer.get_animation("Song1")
	$"4_subdivisions".animation = $SongPlayer.get_animation("Song1")
	pass


func _on_v_slider_value_changed(value):
	$"4_subdivisions".bpm=value
	$"8_subdivisions".bpm=value
