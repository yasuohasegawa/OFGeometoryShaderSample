#version 150
#define NUM_VERTS 36

layout(triangles) in;
layout(triangle_strip) out;
layout(max_vertices = NUM_VERTS) out;

uniform float time;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
uniform mat4 cameraMatrix;
uniform vec3 lightPos;

out vec4 colorOut;

const vec4 diffuseColor = vec4(0,0,1,1);

vec3 GetNormal()
{
   vec3 a = vec3(gl_in[0].gl_Position) - vec3(gl_in[1].gl_Position);
   vec3 b = vec3(gl_in[2].gl_Position) - vec3(gl_in[1].gl_Position);
   return normalize(cross(a, b));
} 
void main() {
    vec3 normal = GetNormal();
    float f = 6.0;

    vec4 verts[NUM_VERTS] = {
      vec4( -f,  f,  f, 0.0f), vec4(  f,  f,  f, 0.0f), vec4(  f,  f, -f, 0.0f),    //Top                                 
      vec4(  f,  f, -f, 0.0f), vec4( -f,  f, -f, 0.0f), vec4( -f,  f,  f, 0.0f),    //Top
      vec4(  f,  f, -f, 0.0f), vec4(  f,  f,  f, 0.0f), vec4(  f, -f,  f, 0.0f),     //Right
      vec4(  f, -f,  f, 0.0f), vec4(  f, -f, -f, 0.0f), vec4(  f,  f, -f, 0.0f),     //Right
      vec4( -f,  f, -f, 0.0f), vec4(  f,  f, -f, 0.0f), vec4(  f, -f, -f, 0.0f),     //Front
      vec4(  f, -f, -f, 0.0f), vec4( -f, -f, -f, 0.0f), vec4( -f,  f, -f, 0.0f),     //Front
      vec4( -f, -f, -f, 0.0f), vec4(  f, -f, -f, 0.0f), vec4(  f, -f,  f, 0.0f),    //Bottom                                         
      vec4(  f, -f,  f, 0.0f), vec4( -f, -f,  f, 0.0f), vec4( -f, -f, -f, 0.0f),     //Bottom
      vec4( -f,  f,  f, 0.0f), vec4( -f,  f, -f, 0.0f), vec4( -f, -f, -f, 0.0f),    //Left
      vec4( -f, -f, -f, 0.0f), vec4( -f, -f,  f, 0.0f), vec4( -f,  f,  f, 0.0f),    //Left
      vec4( -f,  f,  f, 0.0f), vec4( -f, -f,  f, 0.0f), vec4(  f, -f,  f, 0.0f),    //Back
      vec4(  f, -f,  f, 0.0f), vec4(  f,  f,  f, 0.0f), vec4( -f,  f,  f, 0.0f)     //Back
    };  
                                                  
    int indices[NUM_VERTS] = {
      0, 1, 2,  3, 4, 5,
      6, 7, 8,  9,10,11,
      12,13,14, 15,16,17,
      18,19,20, 21,22,23,
      24,25,26, 27,28,29,
      30,31,32, 33,34,35
    };
    
    float sp = 3.0;
    float dist = 50.0;
    for(int i = 0; i < gl_in.length(); i++) {
      // create cube
      vec3 front_vector = vec3(0,0,1);
      vec3 up_vector = vec3(0,1,0);     
      vec3 right_vector = cross(front_vector, up_vector);

      for(int j = 0; j < NUM_VERTS; j++){
        vec4 movePos = vec4(normal * cos(time * sp + gl_in[i].gl_Position.x) * dist + vec3(gl_in[i].gl_Position.xyz),1.0);
        vec4 cube = vec4((gl_in[i].gl_Position.xyz + verts[j].x * right_vector + verts[j].y * up_vector + verts[j].z * front_vector), 1);
        gl_Position = modelViewProjectionMatrix*(cube+movePos);
        EmitVertex();
      }

      mat3 normalMat = transpose(inverse(mat3(model*view)));
      vec4 cameraSpaceLightPos = vec4(lightPos,1.0)*cameraMatrix;
      vec3 vertexNormal = normalize(normalMat * normal);
      vec3 cameraSpaceVertexPos = vec3((model*view) * gl_in[i].gl_Position);
      vec3 lightDir = normalize(cameraSpaceLightPos.xyz - cameraSpaceVertexPos);
      float intensity = max(dot(vertexNormal,lightDir), 0.0);
      colorOut = diffuseColor * intensity;
      colorOut.w = 1.0;

    }
    EndPrimitive();
}