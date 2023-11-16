extends MeshInstance3D

# Set the material for the mesh
func _ready():
	var material = StandardMaterial3D.new()
	self.material_override = material

# Update the color based on audio spectrum data
func _process(delta: float):
	update_color() 

func update_color():
	if Globals.lerped_spectrum.size() > 0:
		# Map the audio spectrum data to a color gradient
		var spectrum_value = Globals.lerped_spectrum[4]
		var color = map_spectrum_to_color(spectrum_value)
		# Apply the color to the material
		self.material_override.albedo_color = color

# Map audio spectrum data to a color gradient
func map_spectrum_to_color(value: float) -> Color:
	var red = 1.0 - value
	var green = value
	var blue = .5 - (value * .5)
	return Color(red, green, blue)
	print(value)
