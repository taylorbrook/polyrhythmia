shader_type spatial;
render_mode unshaded;

global uniform sampler2D spectrum_texture;
uniform sampler2D albedo : source_color;

varying float spectrum_value;

void fragment() {
	ALBEDO = texture(albedo,UV).rgb;
}

void vertex() {
	spectrum_value = texture(spectrum_texture,vec2(0.3,0)).r;
	VERTEX *= 1.0 + spectrum_value;
}
