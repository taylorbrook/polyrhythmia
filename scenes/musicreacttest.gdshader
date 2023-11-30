shader_type spatial;
render_mode unshaded;

uniform sampler2D albedo: source_color;

void fragment() {
	ALBEDO = texture(albedo,UV).rgb;
}
