extends Node3D

func _ready():
	Sound.menu_music_start()
	Globals.levelName="tutorial_onewheel"
	$AnimationPlayer.play("cameraSway")
	var tween = create_tween().set_loops()
	tween.tween_property($LevelWheel/levelName, "scale", Vector3(1.1,1.1,1.1), 3/2).from_current().set_ease(Tween.EASE_OUT)


func _on_button_pressed():
	$GUI/settings.visible = false
