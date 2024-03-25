shader_type canvas_item;
uniform float strength = 1.;
uniform float speed = 1.;

void vertex() {
	float offset1 = sin(TIME * speed) * strength;
	float offset2 = cos(TIME * speed * 2.) * strength;
		VERTEX.x += offset1 * step(1., 1. - VERTEX.y);
		VERTEX.y +=  offset2 * step(1., 1. - VERTEX.y);
}