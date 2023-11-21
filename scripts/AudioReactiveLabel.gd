extends Label3D


func _process(delta):
	var spectrum1 = abs(Globals.lerped_spectrum[3])
	var spectrum2 = abs(Globals.lerped_spectrum[4])
	var spectrum3 = abs(Globals.lerped_spectrum[5])
	#var amplitude = AudioServer.get_bus_peak_volume_right_db(0,0)
	var red = .1 + spectrum1 / 3
	var green = .1 + spectrum2 / 3
	var blue = .4 + spectrum3 / 3
	modulate = Color(red, green, blue)
