extends Node3D

@export var SongName: String = "tutorial_onewheel"

func _ready():
	$MainCam/Camera3D/AnimationPlayer.play("running")
	$"2_subdivisions".song_player = $SongPlayer
	$"3_subdivisions".song_player = $SongPlayer
	$"4_subdivisions".song_player = $SongPlayer
	$"5_subdivisions".song_player = $SongPlayer
	$"6_subdivisions".song_player = $SongPlayer
	$"7_subdivisions".song_player = $SongPlayer
	await get_tree().create_timer(1.0).timeout
	$SongPlayer.play(SongName)

func _on_v_slider_value_changed(value):
	$"4_subdivisions".bpm=value
	$"2_subdivisions".bpm=value
