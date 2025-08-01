
namespace ygo {

  irr::s32 Game::init_irrlicht_shader_5(irr::video::IGPUProgrammingServices *gpu_, irr::IrrlichtDevice *device_) {
    const irr::c8 *vertexShader = R"(
      // 顶点着色器
      uniform mat4 mWorldViewProj;
      uniform float iTime;
      varying vec2 texCoord;

      void main() {
        float breathing = sin(iTime * 1.5) * 0.05 + 1.0;
        
        // 自动中心计算 (使用空闲的纹理坐标)
        vec2 center = (gl_MultiTexCoord1.xy + gl_MultiTexCoord2.xy + 
                      gl_MultiTexCoord3.xy + gl_Vertex.xy) * 0.25;
        
        vec4 pos = gl_Vertex;
        pos.xy = center + (pos.xy - center) * breathing;
        
        gl_Position = mWorldViewProj * pos;
        texCoord = gl_MultiTexCoord0.xy;
      }
    )";

    // 使用老版本GLSL语法的片段着色器
    const irr::c8 *pixelShader = R"(
      // 片段着色器
      uniform sampler2D myTexture;
      uniform float iTime;
      varying vec2 texCoord;

      void main() {
        vec4 baseColor = texture2D(myTexture, texCoord);
        
        // 基于透明度的边缘检测
        float edge = smoothstep(0.3, 0.8, 1.0 - baseColor.a);
        
        // 动态流光
        float wave = sin(iTime * 3.0 + texCoord.x * 8.0) * 0.5 + 0.5;
        vec3 glow = vec3(0.4, 0.2, 0.9) * wave;
        
        // 最终混合
        vec3 result = mix(baseColor.rgb, glow, edge * 0.7);
        gl_FragColor = vec4(result, baseColor.a);
      }
    )";

    irrlicht_shader_callback_1 *callback = new irrlicht_shader_callback_1(device_);
    auto materialType = gpu_->addHighLevelShaderMaterial(vertexShader, "main", irr::video::EVST_VS_1_1, pixelShader, "main", irr::video::EPST_PS_1_1, callback, irr::video::EMT_TRANSPARENT_ADD_COLOR);
    callback->drop();
    return materialType;
  }

} // namespace ygo
