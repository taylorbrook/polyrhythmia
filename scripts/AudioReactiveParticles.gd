extends GPUParticles3D

var amplitude

# Called when the node enters the scene tree for the first time.
func _ready():
	lifetime = Globals.bpm / 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var amplitude = AudioServer.get_bus_peak_volume_right_db(0,0)
	speed_scale = Globals.lerped_spectrum[4]
	process_material.emission_sphere_radius = Globals.lerped_spectrum[4]
	process_material.gravity.x = Globals.lerped_spectrum[4] / 2
	#print(Globals.lerped_spectrum[4])
	#print(amplitude)
