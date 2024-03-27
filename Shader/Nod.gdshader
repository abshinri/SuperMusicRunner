shader_type canvas_item;
uniform float strength = 1.;
uniform float speed = 4.;

void vertex() {
	float offset = sin(TIME * speed * 4.) * (strength / 2.) + sin(TIME * speed * 2.) * strength;
	VERTEX.y +=  offset * step(1., 0.8 - VERTEX.y);
}