#version 150
out vec4 Out_Color;
in  vec4 colorOut;

void main() {
    Out_Color = colorOut+vec4(0.5,0.0,0.0,1.0);
}