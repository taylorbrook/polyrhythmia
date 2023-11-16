extends Node

var bpm = 30.0

#There will likely be background loading code in here as well.

#audio spectrum data - may not use the shader materials or image, 
#but the lerped_spectrum can provide data for all sorts of audioreactive vicuals
var Multiplier:float = 6
const VU_COUNT = 12
const FREQ_MAX = 10000.0
const MIN_DB = 66
var lerp_smoothing: float = 4
var lerped_spectrum: Array[float] = []
var spectrum
var image_texture: ImageTexture
var image: Image

func _ready():
	lerped_spectrum.resize(VU_COUNT)
	image = Image.create(VU_COUNT,1,false, Image.FORMAT_RGBA8)
	for i in VU_COUNT:
		image.set_pixel(i,0, Color.BLACK)
	image_texture = ImageTexture.create_from_image(image)
	RenderingServer.global_shader_parameter_set("spectrum_texture", image_texture)
	spectrum = AudioServer.get_bus_effect_instance(0,1)

func _process(delta: float) -> void:
	var prev_hz = 0
	for i in range(1, VU_COUNT+1):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var effect = energy * Multiplier
		lerped_spectrum[i-1] = lerp(lerped_spectrum[i-1],effect,delta * 4)
		image.set_pixel(i-1,0, Color.WHITE * lerped_spectrum[i-1])
		prev_hz = hz
		
	image_texture.update(image)
