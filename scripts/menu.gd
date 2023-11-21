extends Node3D


func _ready():
	Sound.menu_music_start()
	$AnimationPlayer.play("cameraSway")

func _process(delta):
	pass
