shader_type canvas_item;

uniform vec3 color1 : source_color = vec3(1.0, 0.0, 0.0); // 红色
uniform vec3 color2 : source_color = vec3(0.0, 0.0, 1.0); // 蓝色
// 控制颜色过渡速度的参数
uniform float transition_speed : hint_range(0.1, 2.0, 0.01) = 0.5;


void fragment() {
	
	vec4 color = texture(TEXTURE, UV);

	float t = (sin(TIME * transition_speed) + 1.0) * 0.5;
	// 使用线性插值（lerp）来在 color1 和 color2 之间过渡
	vec3 interpolated_color = mix(color1, color2, t);
//

	// 如果当前像素是不透明的
	if (color.a > 0.0) {
		// 替换颜色
		color = vec4(interpolated_color, color.a);
	} else {
		// 保持透明像素不变
		color = color;
	}
	
	COLOR = texture(TEXTURE ,UV) * color ;
}
