#include "CGUIScrollMessage.h"
#ifdef _IRR_COMPILE_WITH_GUI_

#include "IGUISkin.h"
#include "CGUIEnvironment.h"
#include "IGUIButton.h"
#include "ITexture.h"
#include "CGUIModalScreen.h"

namespace irr {
  namespace gui {

    //! Adds a message box.
    //~ IGUIWindow* CGUIScrollMessage::addScrollMessage(IGUIEnvironment* env, const wchar_t* caption, const wchar_t* text, bool modal, s32 flag, IGUIElement* parent, s32 id, video::ITexture* image) {
    //~ IGUIWindow* CGUIScrollMessage::addScrollMessage(IGUIEnvironment* env, const wchar_t* caption, const wchar_t* text, s32 flag, IGUIElement* parent, s32 id, video::ITexture* image) {
    //~ IGUIWindow* CGUIScrollMessage::addScrollMessage(IGUIEnvironment* env, const wchar_t* text, s32 flag, IGUIElement* parent, s32 id, video::ITexture* image) {
    //~ CGUIScrollMessage* CGUIScrollMessage::addScrollMessage(IGUIEnvironment* env, core::rect<s32> rect, const wchar_t* text, s32 flag, IGUIElement* parent, s32 id, video::ITexture* image) {
    //~ CGUIScrollMessage* CGUIScrollMessage::addScrollMessage(IGUIEnvironment* env, core::rect<s32> rect, s32 flag, IGUIElement* parent, s32 id, video::ITexture* image) {
    CGUIScrollMessage *CGUIScrollMessage::addScrollMessage(IGUIEnvironment *env, core::rect<s32> rect, s32 flag, IGUIElement *parent, s32 id) {
      //~ if (! CurrentSkin)
      //~ return 0;

      parent = parent ? parent : dynamic_cast<CGUIEnvironment *>(env);
      //~ parent = parent ? parent : -1;
      //~ parent = parent ? parent : reinterpret_cast<IGUIElement*>(env);
      //~ parent = parent ? parent : 0;
      //~ parent = parent ? parent : 0;

      //~ core::rect<s32> rect;
      //~ core::dimension2d<u32> screenDim, msgBoxDim;

      //~ screenDim.Width = parent->getAbsolutePosition().getWidth();
      //~ screenDim.Height = parent->getAbsolutePosition().getHeight();
      //~ msgBoxDim.Width = 2;
      //~ msgBoxDim.Height = 2;

      //~ rect.UpperLeftCorner.X = (screenDim.Width - msgBoxDim.Width) / 2;
      //~ rect.UpperLeftCorner.Y = (screenDim.Height - msgBoxDim.Height) / 2;
      //~ rect.LowerRightCorner.X = rect.UpperLeftCorner.X + msgBoxDim.Width;
      //~ rect.LowerRightCorner.Y = rect.UpperLeftCorner.Y + msgBoxDim.Height;

      //~ CGUIScrollMessage* win = new CGUIScrollMessage(env, caption,text, flag, parent, id, rect, image);
      //~ CGUIScrollMessage* win = new CGUIScrollMessage(env, text, flag, parent, id, rect, image);
      //~ CGUIScrollMessage* win = new CGUIScrollMessage(env, flag, parent, id, rect, image);
      CGUIScrollMessage *win = new CGUIScrollMessage(env, flag, parent, id, rect);
      win->drop();

      //~ win->ScrollText = irr::gui::CGUIScrollText::addScrollText(env, L"", irr::core::rect<irr::s32>(0,0,1,1), false, true, win);
      //~ win->ScrollText->setSubElement(true);

      //~ if (modal) {
      //~ // Careful, don't just set the modal as parent above. That will mess up the focus (and is hard to change because we have to be very
      //~ // careful not to get virtual function call, like OnEvent, in the CGUIScrollMessage.
      //~ CGUIModalScreen* modalScreen = new CGUIModalScreen(env, parent, -1);
      //~ modalScreen->drop();
      //~ modalScreen->addChild(win);
      //~ }

      return win;
    }

    //! constructor
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* caption, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), StaticText(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), StaticText(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : environment->addWindow(rectangle, false, 0, parent, id), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), StaticText(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), StaticText(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : OkButton(0), CancelButton(0), YesButton(0), NoButton(0), StaticText(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), Icon(0), IconTexture(image), Flags(flags), MessageText(text), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, const wchar_t* text, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), Icon(0), IconTexture(image), Flags(flags), Pressed(false) {
    //~ CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment* environment, s32 flags, IGUIElement* parent, s32 id, core::rect<s32> rectangle, video::ITexture* image) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), YesButton(0), NoButton(0), Icon(0), IconTexture(image), Flags(flags), Pressed(false) {
    CGUIScrollMessage::CGUIScrollMessage(IGUIEnvironment *environment, s32 flags, IGUIElement *parent, s32 id, core::rect<s32> rectangle) : CGUIWindow(environment, parent, id, rectangle), OkButton(0), CancelButton(0), Flags(flags), Pressed(false) {
#ifdef _DEBUG
      setDebugName("CGUIScrollMessage");
#endif

      //~ Window = environment->addWindow(rectangle, false, 0, parent, id);

      //~ ScrollText = irr::gui::CGUIScrollText::addScrollText(environment, L"", irr::core::rect<irr::s32>(0,0,1,1), false, true, this);
      ScrollText = irr::gui::CGUIScrollText::addScrollText(environment, L"", rectangle, false, true, this, false);
      ScrollText->setSubElement(true);
      ScrollText->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);

      //~ ScrollText->grab();

      /*
      OkButton
      CancelButton
      YesButton
      NoButton
      cc.gc @w

      $a.1 = Environment->addButton(rectangle, this);
      $a.1->setSubElement(true);
      $a.1->grab();
      cc.p
      */
      const IGUISkin *skin = Environment->getSkin();
      OkButton = Environment->addButton(rectangle, this);
      OkButton->setSubElement(true);
      OkButton->setText(skin->getDefaultText(EGDT_MSG_BOX_OK));
      //~ OkButton->grab();
      CancelButton = Environment->addButton(rectangle, this);
      CancelButton->setSubElement(true);
      CancelButton->setText(skin->getDefaultText(EGDT_MSG_BOX_CANCEL));
      //~ CancelButton->grab();
      //~ YesButton = Environment->addButton(rectangle, this);
      //~ YesButton->setSubElement(true);
      //~ YesButton->grab();
      //~ NoButton = Environment->addButton(rectangle, this);
      //~ NoButton->setSubElement(true);
      //~ NoButton->grab();

      // set element type
      //~ Type = EGUIET_MESSAGE_BOX;

      // remove focus
      //~ Environment->setFocus(0);

      // remove buttons

      getMaximizeButton()->remove();
      getMinimizeButton()->remove();
      getCloseButton()->remove();

      //~ if (caption)
      //~ setText(caption);

      //~ Environment->setFocus(this);

      //~ if (IconTexture) {
      //~ IconTexture->grab();
      //~ }

      //~ refreshControls();
      //~ setVisible(false);
    }

    //! destructor
    CGUIScrollMessage::~CGUIScrollMessage() {
      //~ if (ScrollText)
      //~ ScrollText->drop();

      //~ if (OkButton)
      //~ OkButton->drop();

      //~ if (CancelButton)
      //~ CancelButton->drop();

      //~ if (YesButton)
      //~ YesButton->drop();

      //~ if (NoButton)
      //~ NoButton->drop();

      //~ if (Icon) {
      //~ Icon->drop();
      //~ }

      //~ if (IconTexture) {
      //~ IconTexture->drop();
      //~ }
    }

    //~ void CGUIScrollMessage::setButton(IGUIButton*& button, bool isAvailable, const core::rect<s32>& btnRect, const wchar_t* text, IGUIElement*& focusMe) {
    // add/remove ok button
    //~ if (isAvailable) {
    //~ if (! button) {
    //~ button = Environment->addButton(btnRect, this);
    //~ button->setSubElement(true);
    //~ button->grab();
    //~ }
    //~ else
    //~ button->setRelativePosition(btnRect);

    //~ button->setText(text);
    //~ button->setVisible(true);

    //~ focusMe = button;
    //~ }
    //~ else if (button) {
    //~ button->drop();
    //~ button->setVisible(false);
    //~ button->remove();
    //~ button = 0;
    //~ button = 0;
    //~ }
    //~ }

    void CGUIScrollMessage::refreshControls() {
      // Layout can be seen as 4 boxes (a layoutmanager would be nice)
      // One box at top over the whole width for title
      // Two boxes with same height at the middle beside each other for icon and for text
      // One box at the bottom for the buttons

      //~ const IGUISkin* skin = Environment->getSkin();

      //~ const s32 buttonHeight = skin->getSize(EGDS_BUTTON_HEIGHT);
      //~ const s32 buttonWidth = skin->getSize(EGDS_BUTTON_WIDTH);
      //~ const s32 titleHeight = skin->getSize(EGDS_WINDOW_BUTTON_WIDTH) + 2; // titlebar has no own constant
      //~ const s32 buttonDistance = skin->getSize(EGDS_WINDOW_BUTTON_WIDTH);
      //~ const s32 borderWidth = skin->getSize(EGDS_MESSAGE_BOX_GAP_SPACE);

      //~ auto borderHeight = borderWidth;

      //~ s32 buttonBoxHeight = buttonHeight + 2 * borderWidth;

      //~ // add the static text for the message
      //~ core::rect<s32> staticRect;
      //~ staticRect.UpperLeftCorner.X = borderWidth;
      //~ staticRect.UpperLeftCorner.Y = titleHeight + borderWidth;
      //~ staticRect.LowerRightCorner.X = RelativeRect.getWidth() - borderWidth;
      //~ staticRect.LowerRightCorner.Y = RelativeRect.getHeight() - borderHeight - buttonBoxHeight;
      //~ if (! StaticText) {
      //~ StaticText = Environment->addStaticText(MessageText.c_str(), staticRect, false, false, this);

      //~ StaticText->setWordWrap(true);
      //~ StaticText->setSubElement(true);
      //~ StaticText->grab();
      //~ }
      //~ else {
      //~ ScrollText->setRelativePosition(staticRect);
      //~ StaticText->setText(MessageText.c_str());
      //~ }

      //~ s32 textHeight = ScrollText->getRelativePosition().getHeight();
      //~ s32 textWidth = ScrollText->getRelativePosition().getWidth() + 6; // +6 because the static itself needs that
      //~ const s32 iconHeight = IconTexture ? IconTexture->getOriginalSize().Height : 0;

      //~ if (textWidth < skin->getSize(EGDS_MESSAGE_BOX_MIN_TEXT_WIDTH)) {
      //~ textWidth = skin->getSize(EGDS_MESSAGE_BOX_MIN_TEXT_WIDTH) + 6;
      //~ }
      //~ // no neeed to check for max because it couldn't get larger due to statictextbox.
      //~ if (textHeight < skin->getSize(EGDS_MESSAGE_BOX_MIN_TEXT_HEIGHT)) {
      //~ textHeight = skin->getSize(EGDS_MESSAGE_BOX_MIN_TEXT_HEIGHT);
      //~ }
      //~ if (textHeight > skin->getSize(EGDS_MESSAGE_BOX_MAX_TEXT_HEIGHT)) {
      //~ textHeight = skin->getSize(EGDS_MESSAGE_BOX_MAX_TEXT_HEIGHT);
      //~ }

      // content is text + icons + borders (but not titlebar)
      //~ s32 contentHeight = textHeight > iconHeight ? textHeight : iconHeight;
      //~ contentHeight += borderWidth;
      //~ s32 contentWidth = 0;

      // add icon
      //~ if (IconTexture) {
      //~ core::position2d<s32> iconPos;
      //~ iconPos.Y = titleHeight + borderWidth;
      //~ if (iconHeight < textHeight) {
      //~ iconPos.Y += (textHeight - iconHeight) / 2;
      //~ }
      //~ iconPos.X = borderWidth;

      //~ if (!Icon) {
      //~ Icon = Environment->addImage(IconTexture, iconPos, true, this);
      //~ Icon->setSubElement(true);
      //~ Icon->grab();
      //~ }
      //~ else {
      //~ core::rect<s32> iconRect(iconPos.X, iconPos.Y, iconPos.X + IconTexture->getOriginalSize().Width, iconPos.Y + IconTexture->getOriginalSize().Height);
      //~ Icon->setRelativePosition(iconRect);
      //~ }

      //~ contentWidth += borderWidth + IconTexture->getOriginalSize().Width;
      //~ }
      //~ else if (Icon) {
      //~ Icon->drop();
      //~ Icon->remove();
      //~ Icon = 0;
      //~ }

      // position text
      //~ core::rect<s32> textRect;
      //~ textRect.UpperLeftCorner.X = contentWidth + borderWidth;
      //~ textRect.UpperLeftCorner.Y = titleHeight + borderWidth;
      //~ if (textHeight < iconHeight) {
      //~ textRect.UpperLeftCorner.Y += (iconHeight - textHeight) / 2;
      //~ }
      //~ textRect.LowerRightCorner.X = textRect.UpperLeftCorner.X + textWidth;
      //~ textRect.LowerRightCorner.Y = textRect.UpperLeftCorner.Y + textHeight;
      //~ contentWidth += 2 * borderWidth + textWidth;
      //~ ScrollText->setRelativePosition(textRect);

      // find out button size needs
      //~ s32 countButtons = 0;
      //~ if (Flags & EMBF_OK) {
      //~ ++countButtons;
      //~ }
      //~ if (Flags & EMBF_CANCEL) {
      //~ ++countButtons;
      //~ }
      //~ if (Flags & EMBF_YES) {
      //~ ++countButtons;
      //~ }
      //~ if (Flags & EMBF_NO) {
      //~ ++countButtons;
      //~ }

      //~ s32 buttonBoxWidth = countButtons * buttonWidth + 2 * borderWidth;
      //~ if (countButtons > 1) {
      //~ buttonBoxWidth += (countButtons - 1) * buttonDistance;
      //~ }

      // calc new message box sizes
      //~ core::rect<s32> tmp = getRelativePosition();
      //~ s32 msgBoxHeight = titleHeight + contentHeight + buttonBoxHeight;
      //~ s32 msgBoxWidth = contentWidth > buttonBoxWidth ? contentWidth : buttonBoxWidth;

      //~ // adjust message box position
      //~ tmp.UpperLeftCorner.Y = (Parent->getAbsolutePosition().getHeight() - msgBoxHeight) / 2;
      //~ tmp.LowerRightCorner.Y = tmp.UpperLeftCorner.Y + msgBoxHeight;
      //~ tmp.UpperLeftCorner.X = (Parent->getAbsolutePosition().getWidth() - msgBoxWidth) / 2;
      //~ tmp.LowerRightCorner.X = tmp.UpperLeftCorner.X + msgBoxWidth;
      //~ setRelativePosition(tmp);

      // add buttons

      //~ core::rect<s32> btnRect;
      //~ btnRect.UpperLeftCorner.Y = titleHeight + contentHeight + borderWidth;
      //~ btnRect.LowerRightCorner.Y = btnRect.UpperLeftCorner.Y + buttonHeight;
      //~ btnRect.UpperLeftCorner.X = borderWidth;
      //~ if (contentWidth > buttonBoxWidth) {
      //~ btnRect.UpperLeftCorner.X += (contentWidth - buttonBoxWidth) / 2; // center buttons
      //~ }
      //~ btnRect.LowerRightCorner.X = btnRect.UpperLeftCorner.X + buttonWidth;

      //~ IGUIElement* focusMe = 0;
      //~ setButton(OkButton, (Flags & EMBF_OK) != 0, btnRect, skin->getDefaultText(EGDT_MSG_BOX_OK), focusMe);
      //~ if ((Flags & EMBF_OK) != 0) {
      //~ OkButton->setText(skin->getDefaultText(EGDT_MSG_BOX_OK));
      //~ }
      //~ if ((Flags & EMBF_CANCEL) != 0) {
      //~ CancelButton->setText(skin->getDefaultText(EGDT_MSG_BOX_CANCEL));
      //~ }
      //~ if ((Flags & EMBF_YES) != 0) {
      //~ YesButton->setText(skin->getDefaultText(EGDT_MSG_BOX_YES));
      //~ }
      //~ if ((Flags & EMBF_NO) != 0) {
      //~ NoButton->setText(skin->getDefaultText(EGDT_MSG_BOX_NO));
      //~ }
      //~ if (Flags & EMBF_OK) {
      //~ btnRect += core::position2d<s32>(buttonWidth + buttonDistance, 0);
      //~ focusMe = OkButton;
      //~ }
      //~ setButton(CancelButton, (Flags & EMBF_CANCEL) != 0, btnRect, skin->getDefaultText(EGDT_MSG_BOX_CANCEL), focusMe);
      //~ if (Flags & EMBF_CANCEL) {
      //~ btnRect += core::position2d<s32>(buttonWidth + buttonDistance, 0);
      //~ }
      //~ setButton(YesButton, (Flags & EMBF_YES) != 0, btnRect, skin->getDefaultText(EGDT_MSG_BOX_YES), focusMe);
      //~ if (Flags & EMBF_YES) {
      //~ btnRect += core::position2d<s32>(buttonWidth + buttonDistance, 0);
      //~ }
      //~ setButton(NoButton, (Flags & EMBF_NO) != 0, btnRect, skin->getDefaultText(EGDT_MSG_BOX_NO), focusMe);

      //~ if (Environment->hasFocus(this) && focusMe) {
      Environment->setFocus(OkButton);
      //~ }
      //~ ScrollText->breakText();
      f32 grid = 50;

      if (Flags & EMBF_CANCEL) {
        ScrollText->setRelativePositionProportional(core::rect<f32>(1 / grid, 8 / grid, 49 / grid, 39 / grid));
        OkButton->setRelativePositionProportional(core::rect<f32>(12 / grid, 40 / grid, 22 / grid, 48 / grid));
        CancelButton->setRelativePositionProportional(core::rect<f32>(28 / grid, 40 / grid, 38 / grid, 48 / grid));
      }
      else {
        ScrollText->setRelativePositionProportional(core::rect<f32>(1 / grid, 8 / grid, 49 / grid, 39 / grid));
        OkButton->setRelativePositionProportional(core::rect<f32>(20 / grid, 40 / grid, 31 / grid, 48 / grid));
        CancelButton->setVisible(false);
      }

      //~ ScrollText->breakText();
      //~ ScrollText->setText(L"");
      //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      //~ setVisible(true);
      //~ ScrollText->setText(L"");
      //~ setVisible(false);
      //~ printf("dsdf\n");
    }

    //! called if an event happened.
    bool CGUIScrollMessage::OnEvent(const SEvent &event) {
      if (isEnabled()) {
        SEvent outevent;
        outevent.EventType = EET_GUI_EVENT;
        outevent.GUIEvent.Caller = this;
        outevent.GUIEvent.Element = 0;
        switch (event.EventType) {
          case EET_KEY_INPUT_EVENT: {
            //~ printf("这是用 printf 输出的日志\n");
            //~ fast_io::io::print(fast_io::win32_box_t(),
            //~ fast_io::concat(static_cast<int32_t>(event.KeyInput.Key)), "\n",
            //~ __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
            //~ if (event.KeyInput.PressedDown) {
            //~ switch (event.KeyInput.Key) {
            //~ case KEY_RETURN: {
            //~ if (OkButton) {
            //~ OkButton->setPressed(true);
            //~ Pressed = true;
            //~ }
            //~ break;
            //~ }
            //~ case KEY_KEY_Y: {
            //~ if (YesButton) {
            //~ YesButton->setPressed(true);
            //~ Pressed = true;
            //~ }
            //~ break;
            //~ }
            //~ case KEY_KEY_N: {
            //~ if (NoButton) {
            //~ NoButton->setPressed(true);
            //~ Pressed = true;
            //~ }
            //~ break;
            //~ }
            //~ case KEY_ESCAPE: {
            //~ if (Pressed) {
            //~ // cancel press
            //~ if (OkButton) {
            //~ OkButton->setPressed(false);
            //~ }
            //~ if (YesButton) {
            //~ YesButton->setPressed(false);
            //~ }
            //~ if (NoButton) {
            //~ NoButton->setPressed(false);
            //~ }
            //~ Pressed = false;
            //~ }
            //~ else if (CancelButton) {
            //~ CancelButton->setPressed(true);
            //~ Pressed = true;
            //~ }
            //~ else if (CloseButton && CloseButton->isVisible()) {
            //~ CloseButton->setPressed(true);
            //~ Pressed = true;
            //~ }
            //~ break;
            //~ }
            //~ default: {
            //~ break;
            //~ }
            //~ }
            //~ }
            //~ else if (Pressed) {
            //~ setToolTipText(core::stringw(event.KeyInput.Key).c_str());
            //~ setToolTipText(L"34");
            if (OkButton && event.KeyInput.Key == KEY_KEY_Y or event.KeyInput.Key == KEY_SPACE) {
              //~ refreshControls();
              //~ printf("dfdsf\n");
              setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
              Environment->setFocus(0);
              outevent.GUIEvent.EventType = EGET_MESSAGEBOX_OK;
              Parent->OnEvent(outevent);
              setVisible(false);
              return true;
            }
            //~ else if ((CancelButton || CloseButton) && event.KeyInput.Key == KEY_ESCAPE) {
            //~ setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
            //~ Environment->setFocus(0);
            //~ outevent.GUIEvent.EventType = EGET_MESSAGEBOX_CANCEL;
            //~ Parent->OnEvent(outevent);
            //~ setVisible(false);
            //~ return true;
            //~ }
            //~ else if (YesButton && event.KeyInput.Key == KEY_KEY_Y) {
            //~ setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
            //~ Environment->setFocus(0);
            //~ outevent.GUIEvent.EventType = EGET_MESSAGEBOX_YES;
            //~ Parent->OnEvent(outevent);
            //~ setVisible(false);
            //~ return true;
            //~ }
            //~ else if (NoButton && event.KeyInput.Key == KEY_KEY_N) {
            //~ setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
            //~ Environment->setFocus(0);
            //~ outevent.GUIEvent.EventType = EGET_MESSAGEBOX_NO;
            //~ Parent->OnEvent(outevent);
            //~ setVisible(false);
            //~ return true;
            //~ }
            //~ }
            break;
          }
          case EET_GUI_EVENT: {
            if (event.GUIEvent.EventType == EGET_BUTTON_CLICKED) {
              if (event.GUIEvent.Caller == OkButton) {
                setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
                Environment->setFocus(0);
                outevent.GUIEvent.EventType = EGET_MESSAGEBOX_OK;
                Parent->OnEvent(outevent);
                setVisible(false);
                return true;
              }
              //~ else if (event.GUIEvent.Caller == CancelButton || event.GUIEvent.Caller == CloseButton) {
              else if (event.GUIEvent.Caller == CancelButton) {
                setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
                Environment->setFocus(0);
                outevent.GUIEvent.EventType = EGET_MESSAGEBOX_CANCEL;
                Parent->OnEvent(outevent);
                setVisible(false);
                return true;
              }
              //~ else if (event.GUIEvent.Caller == YesButton) {
              //~ setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
              //~ Environment->setFocus(0);
              //~ outevent.GUIEvent.EventType = EGET_MESSAGEBOX_YES;
              //~ Parent->OnEvent(outevent);
              //~ setVisible(false);
              //~ return true;
              //~ }
              //~ else if (event.GUIEvent.Caller == NoButton) {
              //~ setVisible(false); // this is a workaround to make sure it's no longer the hovered element, crashes on pressing 1-2 times ESC
              //~ Environment->setFocus(0);
              //~ outevent.GUIEvent.EventType = EGET_MESSAGEBOX_NO;
              //~ Parent->OnEvent(outevent);
              //~ setVisible(false);
              //~ return true;
              //~ }
            }
            break;
          }
          default: {
            break;
          }
        }
      }
      //~ refreshControls();
      //~ setVisible(false);
      return CGUIWindow::OnEvent(event);
    }

    //! Writes attributes of the element.
    //~ void CGUIScrollMessage::serializeAttributes(io::IAttributes* out, io::SAttributeReadWriteOptions* options = 0) const {
    //~ CGUIWindow::serializeAttributes(out, options);

    //~ out->addBool("OkayButton", (Flags & EMBF_OK) != 0);
    //~ out->addBool("CancelButton", (Flags & EMBF_CANCEL) != 0);
    //~ out->addBool("YesButton", (Flags & EMBF_YES) != 0);
    //~ out->addBool("NoButton", (Flags & EMBF_NO) != 0);
    //~ out->addTexture("Texture", IconTexture);

    //~ out->addString("MessageText", MessageText.c_str());
    //~ }

    //! Reads attributes of the element
    //~ void CGUIScrollMessage::deserializeAttributes(io::IAttributes* in, io::SAttributeReadWriteOptions* options = 0) {
    //~ Flags = 0;

    //~ Flags = in->getAttributeAsBool("OkayButton") ? EMBF_OK : 0;
    //~ Flags |= in->getAttributeAsBool("CancelButton") ? EMBF_CANCEL : 0;
    //~ Flags |= in->getAttributeAsBool("YesButton") ? EMBF_YES : 0;
    //~ Flags |= in->getAttributeAsBool("NoButton") ? EMBF_NO : 0;

    //~ if (IconTexture) {
    //~ IconTexture->drop();
    //~ IconTexture = NULL;
    //~ }
    //~ IconTexture = in->getAttributeAsTexture("Texture");
    //~ if (IconTexture)
    //~ IconTexture->grab();

    //~ MessageText = in->getAttributeAsStringW("MessageText").c_str();

    //~ CGUIWindow::deserializeAttributes(in, options);

    //~ refreshControls();
    //~ }

    void CGUIScrollMessage::setText_1(const wchar_t *scroll_text, const wchar_t *title_text, s32 flags) {
      //~ printf("23423");
      Flags = flags;
      refreshControls();
      setText(title_text);
      ScrollText->setText(scroll_text);
    }

    //~ void CGUIScrollMessage::draw() {
    //~ IGUIElement::draw();
    //~ refreshControls();
    //~ setVisible(false);
    //~ IGUIElement::draw();
    //~ }

    //~ void CGUIScrollMessage::setRelativePosition(const core::rect<s32>& r) {
    //~ IGUIElement::setRelativePosition(r);
    //~ refreshControls();
    //~ setVisible(false);
    //~ printf("4543\n");
    //~ }

  } // end namespace gui
} // end namespace irr

#endif // _IRR_COMPILE_WITH_GUI_
