extends Node3D

func _ready():
	$MainCam/Camera3D/AnimationPlayer.play("running")
	$"2_subdivisions".song_player = $SongPlayer
	$"4_subdivisions".song_player = $SongPlayer
	$"2_subdivisions".populate_wheel()
	$"4_subdivisions".populate_wheel()
	$SongPlayer.play("Song1")
	$"2_subdivisions".spinning=true
	$"4_subdivisions".spinning=true

func _on_v_slider_value_changed(value):
	$"4_subdivisions".bpm=value
	$"2_subdivisions".bpm=value
