shader_type canvas_item;

uniform vec4 outline_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform float outline_size = 15.0;
uniform bool show_outline = false;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec4 final_color = tex_color;

    if (show_outline) {
        // Sample in 8 directions around the current pixel
        float alpha = 0.0;
        vec2 directions[8] = vec2[](
            vec2(-1, 0), vec2(1, 0), vec2(0, -1), vec2(0, 1),
            vec2(-1, -1), vec2(1, -1), vec2(-1, 1), vec2(1, 1)
        );

        for (int i = 0; i < 8; i++) {
            vec2 offset = directions[i] * outline_size / TEXTURE_PIXEL_SIZE;
            vec4 sample = texture(TEXTURE, UV + offset);
            alpha = max(alpha, sample.a);
        }

        // Always draw outline around sprite (ignore original alpha)
        final_color = mix(outline_color, tex_color, tex_color.a);
    }

    COLOR = final_color;
}
