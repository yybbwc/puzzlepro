
namespace ygo {

  irr::s32 Game::init_irrlicht_shader_2(irr::video::IGPUProgrammingServices *gpu_, irr::IrrlichtDevice *device_) {
    const irr::c8 *vertexShader = R"(
      uniform mat4 mWorldViewProj;
      varying vec2 texCoord;
      
      void main() {
        gl_Position = mWorldViewProj * gl_Vertex;
        texCoord = gl_MultiTexCoord0.xy;
        gl_TexCoord[0] = gl_MultiTexCoord0;
      }
    )";

    // 使用老版本GLSL语法的片段着色器
    const irr::c8 *pixelShader = R"(
      uniform sampler2D myTexture;
      uniform vec2 iResolution;
      uniform float iTime;
      varying vec2 texCoord;
      
      void main() {
        // 原始纹理颜色
        vec4 baseColor = texture2D(myTexture, texCoord);
        
        // 计算到边缘的距离
        vec2 uv = texCoord;
        vec2 edge = abs(uv - 0.5) * 2.0; // 映射到[0,1]
        float border = max(edge.x, edge.y);
        
        // 边缘检测 - 接近1.0表示在边缘
        float edgeFactor = smoothstep(0.7, 1.0, border);
        
        // 流光效果参数
        float speed = iTime * 2.0;
        float wave = sin(uv.x * 10.0 + uv.y * 5.0 + speed) * 0.5 + 0.5;
        
        // 流光颜色 (蓝紫色)
        vec3 glowColor = vec3(0.4 + wave * 0.6, 0.2, 0.8 + wave * 0.4);
        
        // 混合流光效果
        vec3 finalColor = mix(baseColor.rgb, glowColor, edgeFactor * 0.8);
        
        // 边缘发光强度
        float glowIntensity = edgeFactor * (0.6 + 0.4 * sin(iTime * 3.0));
        finalColor += glowColor * glowIntensity;
        
        // 输出最终颜色，保持原始透明度
        gl_FragColor = vec4(finalColor, baseColor.a);
      }
    )";

    irrlicht_shader_callback_1 *callback = new irrlicht_shader_callback_1(device_);
    auto materialType = gpu_->addHighLevelShaderMaterial(vertexShader, "main", irr::video::EVST_VS_1_1, pixelShader, "main", irr::video::EPST_PS_1_1, callback, irr::video::EMT_SOLID);
    callback->drop();
    return materialType;
  }

} // namespace ygo
