
namespace ygo {
  // 添加这个函数到您的代码中
  void Game::Draw2DImageWithShader(irr::video::IVideoDriver *driver, irr::video::ITexture *texture, irr::core::rect<irr::s32> destRect, irr::core::rect<irr::s32> sourceRect, irr::s32 materialType, irr::video::SColor color) {
    // 保存当前变换矩阵
    irr::core::matrix4 oldProjMat = driver->getTransform(irr::video::ETS_PROJECTION);
    irr::core::matrix4 oldViewMat = driver->getTransform(irr::video::ETS_VIEW);
    irr::core::matrix4 oldWorldMat = driver->getTransform(irr::video::ETS_WORLD);

    // 设置正交投影矩阵
    driver->setTransform(irr::video::ETS_PROJECTION, irr::core::matrix4());
    driver->setTransform(irr::video::ETS_VIEW, irr::core::matrix4());
    driver->setTransform(irr::video::ETS_WORLD, irr::core::matrix4());

    // 计算屏幕尺寸
    float screenWidth = (float)driver->getScreenSize().Width;
    float screenHeight = (float)driver->getScreenSize().Height;

    // 计算UV坐标
    irr::core::vector2df uvCorner[4];
    uvCorner[0] = irr::core::vector2df(sourceRect.UpperLeftCorner.X / (float)texture->getOriginalSize().Width, sourceRect.UpperLeftCorner.Y / (float)texture->getOriginalSize().Height);
    uvCorner[1] = irr::core::vector2df(sourceRect.LowerRightCorner.X / (float)texture->getOriginalSize().Width, sourceRect.UpperLeftCorner.Y / (float)texture->getOriginalSize().Height);
    uvCorner[2] = irr::core::vector2df(sourceRect.UpperLeftCorner.X / (float)texture->getOriginalSize().Width, sourceRect.LowerRightCorner.Y / (float)texture->getOriginalSize().Height);
    uvCorner[3] = irr::core::vector2df(sourceRect.LowerRightCorner.X / (float)texture->getOriginalSize().Width, sourceRect.LowerRightCorner.Y / (float)texture->getOriginalSize().Height);

    // 创建顶点数据 - 转换屏幕坐标到标准化设备坐标
    irr::video::S3DVertex vertices[4];
    irr::u16 indices[6] = {0, 1, 2, 3, 2, 1};

    // 左上角
    float screenPosX = ((destRect.UpperLeftCorner.X / screenWidth) - 0.5f) * 2.0f;
    float screenPosY = ((destRect.UpperLeftCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[0].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[0].TCoords = uvCorner[0];
    vertices[0].Color = color;

    // 右上角
    screenPosX = ((destRect.LowerRightCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.UpperLeftCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[1].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[1].TCoords = uvCorner[1];
    vertices[1].Color = color;

    // 左下角
    screenPosX = ((destRect.UpperLeftCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.LowerRightCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[2].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[2].TCoords = uvCorner[2];
    vertices[2].Color = color;

    // 右下角
    screenPosX = ((destRect.LowerRightCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.LowerRightCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[3].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[3].TCoords = uvCorner[3];
    vertices[3].Color = color;

    // 设置材质
    irr::video::SMaterial material;
    material.Lighting = false;
    material.ZWriteEnable = irr::video::EZW_OFF;
    material.MaterialType = static_cast<irr::video::E_MATERIAL_TYPE>(materialType);
    material.setTexture(0, texture);

    // 绘制
    driver->setMaterial(material);
    driver->drawIndexedTriangleList(&vertices[0], 4, &indices[0], 2);

    // 恢复变换矩阵
    driver->setTransform(irr::video::ETS_PROJECTION, oldProjMat);
    driver->setTransform(irr::video::ETS_VIEW, oldViewMat);
    driver->setTransform(irr::video::ETS_WORLD, oldWorldMat);
  }

  //~ void Game::Draw2DImageWithShader(irr::video::IVideoDriver *driver, irr::video::ITexture *texture, irr::core::rect<irr::s32> destRect, irr::s32 materialType, irr::video::SColor color) {
  void Game::Draw2DImageWithShader(irr::video::IVideoDriver *driver, irr::video::ITexture *texture, irr::core::rect<irr::s32> destRect, irr::s32 materialType) {
    // 保存当前变换矩阵
    irr::core::matrix4 oldProjMat = driver->getTransform(irr::video::ETS_PROJECTION);
    irr::core::matrix4 oldViewMat = driver->getTransform(irr::video::ETS_VIEW);
    irr::core::matrix4 oldWorldMat = driver->getTransform(irr::video::ETS_WORLD);

    // 设置正交投影矩阵
    driver->setTransform(irr::video::ETS_PROJECTION, irr::core::matrix4());
    driver->setTransform(irr::video::ETS_VIEW, irr::core::matrix4());
    driver->setTransform(irr::video::ETS_WORLD, irr::core::matrix4());

    irr::core::rect<int32_t> sourceRect(0, 0, texture->getOriginalSize().Width, texture->getOriginalSize().Height);

    // 计算屏幕尺寸
    float screenWidth = (float)driver->getScreenSize().Width;
    float screenHeight = (float)driver->getScreenSize().Height;

    // 计算UV坐标
    irr::core::vector2df uvCorner[4];
    //~ uvCorner[0] = irr::core::vector2df(sourceRect.UpperLeftCorner.X / (float)texture->getOriginalSize().Width, sourceRect.UpperLeftCorner.Y / (float)texture->getOriginalSize().Height);
    //~ uvCorner[1] = irr::core::vector2df(sourceRect.LowerRightCorner.X / (float)texture->getOriginalSize().Width, sourceRect.UpperLeftCorner.Y / (float)texture->getOriginalSize().Height);
    //~ uvCorner[2] = irr::core::vector2df(sourceRect.UpperLeftCorner.X / (float)texture->getOriginalSize().Width, sourceRect.LowerRightCorner.Y / (float)texture->getOriginalSize().Height);
    //~ uvCorner[3] = irr::core::vector2df(sourceRect.LowerRightCorner.X / (float)texture->getOriginalSize().Width, sourceRect.LowerRightCorner.Y / (float)texture->getOriginalSize().Height);

    uvCorner[0] = irr::core::vector2df(0, 0);
    uvCorner[1] = irr::core::vector2df(1, 0);
    uvCorner[2] = irr::core::vector2df(0, 1);
    uvCorner[3] = irr::core::vector2df(1, 1);

    // 创建顶点数据 - 转换屏幕坐标到标准化设备坐标
    irr::video::S3DVertex vertices[4];
    irr::u16 indices[6] = {0, 1, 2, 3, 2, 1};

    // 左上角
    float screenPosX = ((destRect.UpperLeftCorner.X / screenWidth) - 0.5f) * 2.0f;
    float screenPosY = ((destRect.UpperLeftCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[0].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[0].TCoords = uvCorner[0];
    //~ vertices[0].Color = color;

    // 右上角
    screenPosX = ((destRect.LowerRightCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.UpperLeftCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[1].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[1].TCoords = uvCorner[1];
    //~ vertices[1].Color = color;

    // 左下角
    screenPosX = ((destRect.UpperLeftCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.LowerRightCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[2].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[2].TCoords = uvCorner[2];
    //~ vertices[2].Color = color;

    // 右下角
    screenPosX = ((destRect.LowerRightCorner.X / screenWidth) - 0.5f) * 2.0f;
    screenPosY = ((destRect.LowerRightCorner.Y / screenHeight) - 0.5f) * -2.0f;
    vertices[3].Pos = irr::core::vector3df(screenPosX, screenPosY, 1);
    vertices[3].TCoords = uvCorner[3];
    //~ vertices[3].Color = color;

    // 设置材质
    irr::video::SMaterial material;
    material.Lighting = false;
    material.ZWriteEnable = irr::video::EZW_OFF;
    material.MaterialType = static_cast<irr::video::E_MATERIAL_TYPE>(materialType);
    material.setTexture(0, texture);

    // 绘制
    driver->setMaterial(material);
    driver->drawIndexedTriangleList(&vertices[0], 4, &indices[0], 2);

    // 恢复变换矩阵
    driver->setTransform(irr::video::ETS_PROJECTION, oldProjMat);
    driver->setTransform(irr::video::ETS_VIEW, oldViewMat);
    driver->setTransform(irr::video::ETS_WORLD, oldWorldMat);
  }

  //~ irr::s32 init_shader_1(irr::IrrlichtDevice *device_) {
  //~ }

} // namespace ygo
