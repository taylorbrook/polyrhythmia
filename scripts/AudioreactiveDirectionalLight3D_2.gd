extends DirectionalLight3D


func _process(_delta):
	var spectrum1 = abs(Globals.lerped_spectrum[3])
	var spectrum2 = abs(Globals.lerped_spectrum[4])
	var spectrum3 = abs(Globals.lerped_spectrum[5])
	#var amplitude = AudioServer.get_bus_peak_volume_right_db(0,0)
	light_energy = .15 + spectrum1 / 3
	var red = .1 + spectrum1 / 2
	var green = .4 - spectrum2 / 2
	var blue = 1 - spectrum3 / 2
	light_color = Color(red, green, blue)
