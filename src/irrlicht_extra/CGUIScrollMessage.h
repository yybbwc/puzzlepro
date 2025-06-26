// Copyright (C) 2002-2012 Nikolaus Gebhardt
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in irrlicht.h

//~ #ifndef IRR_C_GUI_MESSAGE_BOX_H_INCLUDED
//~ #define IRR_C_GUI_MESSAGE_BOX_H_INCLUDED

#pragma once

#include "IrrCompileConfig.h"
#ifdef _IRR_COMPILE_WITH_GUI_

#include "CGUIWindow.h"
#include "IGUIStaticText.h"
#include "IGUIImage.h"
#include "CGUIScrollText.h"

namespace irr {
  namespace gui {
    class CGUIScrollMessage : public CGUIWindow {
    public:
      //~ //! Adds a message box.
      //~ /** \param caption Text to be displayed the title of the message box.
      //~ \param text Text to be displayed in the body of the message box.
      //~ \param modal Defines if the dialog is modal. This means, that all other
      //~ gui elements which were created before the message box cannot be used
      //~ until this messagebox is removed.
      //~ \param flags Flags specifying the layout of the message box using ::EMESSAGE_BOX_FLAG.
      //~ Create a message box with an OK and CANCEL button for example with (EMBF_OK | EMBF_CANCEL).
      //~ \param parent Parent gui element of the message box.
      //~ \param id Id with which the gui element can be identified.
      //~ \param image Optional texture which will be displayed beside the text as an image
      //~ \return Pointer to the created message box. Returns 0 if an error
      //~ occurred. This pointer should not be dropped. See
      //~ IReferenceCounted::drop() for more information. */
      //~ static IGUIWindow* addScrollMessage(IGUIEnvironment* env, const wchar_t* caption, const wchar_t* text=0, bool modal = true, s32 flags = EMBF_OK, IGUIElement* parent=0, s32 id=-1, video::ITexture* image=0);
      //~ static IGUIWindow* addScrollMessage(IGUIEnvironment* env, const wchar_t* caption, const wchar_t* text=0, s32 flags = EMBF_OK, IGUIElement* parent=0, s32 id=-1, video::ITexture* image=0);
      //~ static IGUIWindow* addScrollMessage(IGUIEnvironment* env, const wchar_t* text=0, s32 flags = EMBF_OK, IGUIElement* parent=0, s32 id=-1, video::ITexture* image=0);
      //~ static CGUIScrollMessage* addScrollMessage(IGUIEnvironment* env, core::rect<s32> rect,const wchar_t* text=0, s32 flags = EMBF_OK, IGUIElement* parent=0, s32 id=-1, video::ITexture* image=0);
      //~ static CGUIScrollMessage* addScrollMessage(IGUIEnvironment* env, core::rect<s32> rect, s32 flags = EMBF_OK, IGUIElement* parent = 0, s32 id = -1, video::ITexture* image = 0);
      static CGUIScrollMessage *addScrollMessage(IGUIEnvironment *env, core::rect<s32> rect, s32 flags = EMBF_OK, IGUIElement *parent = 0, s32 id = -1);

      //! constructor
      //~ CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* caption, const wchar_t* text, s32 flag, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image = 0);
      //~ CGUIScrollMessage(IGUIEnvironment* environment,const wchar_t* text, s32 flag, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image = 0);
      //~ CGUIScrollMessage(IGUIEnvironment* environment, s32 flag, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image = 0);
      CGUIScrollMessage(IGUIEnvironment *environment, s32 flag, IGUIElement *parent, s32 id, core::rect<s32> rectangle);

      //! destructor
      virtual ~CGUIScrollMessage();

      //! called if an event happened.
      virtual bool OnEvent(const SEvent &event) override;

      //! Writes attributes of the element.
      //~ virtual void serializeAttributes(io::IAttributes* out, io::SAttributeReadWriteOptions* options) const override;

      //! Reads attributes of the element
      //~ virtual void deserializeAttributes(io::IAttributes* in, io::SAttributeReadWriteOptions* options) override;

      virtual void setText_1(const wchar_t *scroll_text = L"", const wchar_t *title_text = L"", s32 flags = EMBF_OK);

      void refreshControls();

      //~ virtual void draw() override;

      //~ virtual void setRelativePosition(const core::rect<s32>& r);
    private:
      //~ void setButton(IGUIButton*& button, bool isAvailable, const core::rect<s32>& btnRect, const wchar_t* text, IGUIElement*& focusMe);

      CGUIScrollText *ScrollText;
      IGUIButton *OkButton;
      IGUIButton *CancelButton;
      //~ IGUIButton* YesButton;
      //~ IGUIButton* NoButton;
      //~ IGUIStaticText* StaticText;
      //~ IGUIImage* Icon;
      //~ video::ITexture* IconTexture;

      //~ IGUIWindow* Window;

      s32 Flags;
      core::stringw MessageText;
      bool Pressed;
    };

  } // end namespace gui
} // end namespace irr

#endif // _IRR_COMPILE_WITH_GUI_

//~ #endif
