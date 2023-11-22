extends Node3D


func _ready():
	Sound.menu_music_start()
	$AnimationPlayer.play("cameraSway")
	var tween = create_tween().set_loops()
	tween.tween_property($LevelWheel/levelName, "scale", Vector3(1.1,1.1,1.1), 1).from_current().set_ease(Tween.EASE_OUT)
	#tween.tween_property($LevelWheel/levelName, "scale", Vector3(.95,.95,.95), .5).from_current().set_ease(Tween.EASE_IN)
