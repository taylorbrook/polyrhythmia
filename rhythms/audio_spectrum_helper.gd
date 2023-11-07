extends Node

@export_range(0,10) var Multiplier:float;
const VU_COUNT = 12
const FREQ_MAX = 10000.0
const MIN_DB = 66

var spectrum
var image_texture: ImageTexture
var image: Image

# Called when the node enters the scene tree for the first time.
func _ready():
	image = Image.create(VU_COUNT,1,false, Image.FORMAT_RGBA8)
	for i in VU_COUNT:
		image.set_pixel(i,0, Color.BLACK)
	image_texture = ImageTexture.create_from_image(image)
	RenderingServer.global_shader_parameter_set("spectrum_texture", image_texture)
	spectrum = AudioServer.get_bus_effect_instance(3,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var prev_hz = 0
	
	for i in range(1, VU_COUNT):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var effect = energy * Multiplier
		image.set_pixel(i,0, Color.WHITE * effect)
		prev_hz = hz
		
	image_texture.update(image)
