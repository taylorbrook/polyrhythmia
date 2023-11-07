shader_type spatial;
render_mode unshaded;

global uniform sampler2D spectrum_texture;

void fragment() {
	ALBEDO = texture(spectrum_texture ,UV).rgb;
}
