extends Node

func menu_music_start():
	$menuMusic.play()
	
func menu_music_end():
	$menuMusic.stop()
	
func transition_start():
	$transitionSound.play()
