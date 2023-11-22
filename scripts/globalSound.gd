extends Node

func menu_music_start():
	$menuMusic.volume_db = -30
	$menuMusic.play()
	var tween = create_tween()
	tween.tween_property($menuMusic,"volume_db", -6,3)
	
func transition_start():
	$transitionSound.play()
	var tween = create_tween()
	tween.tween_property($menuMusic,"volume_db", -80,2)
	$menuMusic.stop()
