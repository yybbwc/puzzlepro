#pragma once

//~ #ifndef IMAGEMANAGER_H
//~ #define IMAGEMANAGER_H

namespace ygo {

  class ImageManager {
  public:
    bool Initial();
    void SetDevice(irr::IrrlichtDevice *dev);
    void ClearTexture();
    void RemoveTexture(int code);
    void ResizeTexture();
    irr::video::ITexture *GetTextureFromFile(const char *file, irr::s32 width, irr::s32 height);
    irr::video::ITexture *GetTexture(int code, bool fit = true);
    irr::video::ITexture *GetBigPicture(int code, float zoom);
    irr::video::ITexture *GetTextureThumb(int code);
    //~ irr::video::ITexture *GetTextureThumb(code_pointer cp);
    irr::video::ITexture *GetTextureField(int code);
    static int LoadThumbThread();

    static void imageScaleNNAA(irr::video::IImage *src, irr::video::IImage *dest);

    irr::video::ITexture *GetBigPicture(int code, irr::f32 width, irr::f32 height);

    boost::unordered::unordered_flat_map<int, irr::video::ITexture *> tMap[2];
    boost::unordered::unordered_flat_map<int, irr::video::ITexture *> tThumb;
    boost::unordered::unordered_flat_map<int, irr::video::ITexture *> tFields;
    boost::unordered::unordered_flat_map<int, irr::video::IImage *> tThumbLoading;
    std::queue<int> tThumbLoadingCodes;
    std::mutex tThumbLoadingMutex;
    bool tThumbLoadingThreadRunning;
    irr::IrrlichtDevice *device;
    irr::video::IVideoDriver *driver;
    irr::video::ITexture *tCover[2];
    irr::video::ITexture *tUnknown;
    irr::video::ITexture *tUnknownFit;
    irr::video::ITexture *tUnknownThumb;
    irr::video::ITexture *tBigPicture;
    irr::video::ITexture *tLoading;
    irr::video::ITexture *tAct;
    irr::video::ITexture *tAttack;
    irr::video::ITexture *tNegated;
    irr::video::ITexture *tChain;
    irr::video::ITexture *tNumber;
    irr::video::ITexture *tLPFrame;
    irr::video::ITexture *tLPBar;
    irr::video::ITexture *tMask;
    irr::video::ITexture *tEquip;
    irr::video::ITexture *tTarget;
    irr::video::ITexture *tChainTarget;
    irr::video::ITexture *tLim;
    irr::video::ITexture *tOT;
    irr::video::ITexture *tHand[3];
    irr::video::ITexture *tBackGround;
    irr::video::ITexture *tBackGround_menu;
    irr::video::ITexture *tBackGround_deck;
    irr::video::ITexture *tField[2];
    irr::video::ITexture *tFieldTransparent[2];
    irr::video::ITexture *transparent_texture;
  };

  extern ImageManager imageManager;

} // namespace ygo

//~ #endif // IMAGEMANAGER_H
