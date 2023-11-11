extends Node3D

@export var SongName: String = "tutorial_onewheel"

func _ready():
	$MainCam/Camera3D/AnimationPlayer.play("running")
	await get_tree().create_timer(1.0).timeout
	$SongPlayer.play(SongName)
