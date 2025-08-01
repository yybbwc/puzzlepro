
namespace ygo {

  class irrlicht_shader_callback_1 : public irr::video::IShaderConstantSetCallBack {
  private:
    irr::s32 WorldViewProjID;
    irr::s32 TextureID;
    irr::s32 iResolutionID; // 新增：分辨率uniform
    irr::s32 iTimeID;       // 新增：时间uniform
    irr::IrrlichtDevice *device;

  public:
    irrlicht_shader_callback_1(irr::IrrlichtDevice *device_) : device(device_) {
    }

    virtual void OnCreate(irr::video::IMaterialRendererServices *services, irr::s32 userData) {
      WorldViewProjID = services->getVertexShaderConstantID("mWorldViewProj");
      TextureID = services->getVertexShaderConstantID("myTexture");
      iResolutionID = services->getVertexShaderConstantID("iResolution"); // 获取分辨率ID
      iTimeID = services->getVertexShaderConstantID("iTime");             // 获取时间ID
    }

    virtual void OnSetConstants(irr::video::IMaterialRendererServices *services, irr::s32 userData) {
      irr::video::IVideoDriver *driver = device->getVideoDriver();

      // 设置世界-视图-投影矩阵
      irr::core::matrix4 worldViewProj = driver->getTransform(irr::video::ETS_PROJECTION);
      worldViewProj *= driver->getTransform(irr::video::ETS_VIEW);
      worldViewProj *= driver->getTransform(irr::video::ETS_WORLD);
      services->setVertexShaderConstant(WorldViewProjID, worldViewProj.pointer(), 16);

      // 设置纹理层
      irr::s32 TextureLayerID = 0;
      services->setPixelShaderConstant(TextureID, &TextureLayerID, 1);

      // 设置分辨率 (传递屏幕尺寸)
      irr::core::dimension2d<irr::u32> screenSize = driver->getScreenSize();
      float resolution[] = {(float)screenSize.Width, (float)screenSize.Height};
      services->setVertexShaderConstant(iResolutionID, resolution, 2);

      // 设置时间 (从设备获取运行时间)
      float time = (float)device->getTimer()->getTime() / 1000.0f; // 转换为秒
      services->setVertexShaderConstant(iTimeID, &time, 1);
    }
  };

  irr::s32 Game::init_irrlicht_shader_1(irr::video::IGPUProgrammingServices *gpu_, irr::IrrlichtDevice *device_) {
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
      
      vec3 palette(float t) {
        vec3 a = vec3(0.5, 0.5, 0.5);
        vec3 b = vec3(0.5, 0.5, 0.5);
        vec3 c = vec3(1.0, 1.0, 1.0);
        vec3 d = vec3(0.263, 0.416, 0.557);
        return a + b * cos(6.28318 * (c * t + d));
      }
      
      void main() {
        // 计算UV坐标 (适配屏幕分辨率)
        vec2 uv = (texCoord * iResolution * 2.0 - iResolution.xy) / iResolution.y;
        vec2 uv0 = uv;
        vec3 finalColor = vec3(0.0);
          
        for (float i = 0.0; i < 4.0; i++) {
          uv = fract(uv * 1.5) - 0.5;
          float d = length(uv) * exp(-length(uv0));
          vec3 col = palette(length(uv0) + i * 0.4 + iTime * 0.4);
          
          d = sin(d * 8.0 + iTime) / 8.0;
          d = abs(d);
          d = pow(0.01 / d, 1.2);
          
          finalColor += col * d;
        }
          
        vec4 col = texture2D(myTexture, gl_TexCoord[0].xy);
        gl_FragColor = vec4(finalColor, 0.01); // 半透明效果
        gl_FragColor = col + gl_FragColor;
      }
    )";

    irrlicht_shader_callback_1 *callback = new irrlicht_shader_callback_1(device_);
    auto materialType = gpu_->addHighLevelShaderMaterial(vertexShader, "main", irr::video::EVST_VS_1_1, pixelShader, "main", irr::video::EPST_PS_1_1, callback, irr::video::EMT_SOLID);
    callback->drop();
    return materialType;
  }

} // namespace ygo
