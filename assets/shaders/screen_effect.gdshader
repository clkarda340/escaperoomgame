shader_type canvas_item;

uniform float transparency = 1.0;  // Transparency control from 0 to 1
uniform float amount = 40.0;

void fragment() {
    vec2 uv = UV * 0.05;
    float a = fract(sin(dot(UV, vec2(12.9898, 78.233) * TIME)) * 438.5453) * 1.9;
    vec4 col = texture(TEXTURE, UV);

    // Compute the final alpha using the 'transparency' uniform
    float alpha = pow(a, amount); // Randomized fluctuation of alpha
    alpha = mix(0.0, alpha, transparency); // Smoothly interpolate between 0 (transparent) and 'alpha'

    col.a = alpha; // Assign the computed alpha to the color
    COLOR = col;
}