extends DirectionalLight3D


func _process(delta):
	var spectrum1 = abs(Globals.lerped_spectrum[3])
	var spectrum2 = abs(Globals.lerped_spectrum[4])
	var spectrum3 = abs(Globals.lerped_spectrum[5])
	#var amplitude = AudioServer.get_bus_peak_volume_right_db(0,0)
	light_energy = .4 + spectrum1 / 2
	var red = .4 + spectrum1 / 2
	var green = .3 + spectrum2 / 2
	var blue = .3 + spectrum3 / 2
	light_color = Color(red, green, blue)
