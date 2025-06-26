// Copyright (C) 2002-2012 Nikolaus Gebhardt
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in irrlicht.h
#include "CGUIScrollText.h"
#ifdef _IRR_COMPILE_WITH_GUI_
#include "IGUISkin.h"
#include "IGUIEnvironment.h"
#include "IGUIFont.h"
#include "IVideoDriver.h"
#include "rect.h"
#include "CGUIScrollBar.h"

namespace irr {
  namespace gui {
    //! adds a static text. The returned pointer must not be dropped.
    CGUIScrollText *CGUIScrollText::addScrollText(IGUIEnvironment *env, const wchar_t *text, const core::rect<s32> &rectangle, bool border, bool wordWrap, IGUIElement *parent, s32 id, bool background) {
      CGUIScrollText *d = new CGUIScrollText(text, border, env, parent ? parent : 0, id, rectangle, background);
      d->setWordWrap(wordWrap);
      d->drop();
      return d;
    }

    //! constructor
    CGUIScrollText::CGUIScrollText(const wchar_t *text, bool border, IGUIEnvironment *environment, IGUIElement *parent, s32 id, const core::rect<s32> &rectangle, bool background) : IGUIStaticText(environment, parent, id, rectangle), HAlign(EGUIA_UPPERLEFT), VAlign(EGUIA_UPPERLEFT), Border(border), OverrideColorEnabled(false), OverrideBGColorEnabled(false), WordWrap(false), Background(background), RestrainTextInside(true), RightToLeft(false), OverrideColor(video::SColor(101, 255, 255, 255)), BGColor(video::SColor(101, 210, 210, 210)), OverrideFont(0), LastBreakFont(0) {
#ifdef _DEBUG
      setDebugName("CGUIScrollText");
#endif
      Text = text;
      IGUISkin *skin = Environment->getSkin();
      BGColor = skin->getColor(gui::EGDC_3D_FACE);
      ScrollBar = new CGUIScrollBar(false, Environment, this, -1, core::recti(0, 0, 1, 1), false);
      ScrollBar->setSubElement(true);
      ScrollBar->setTabStop(false);
      ScrollBar->setAlignment(EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT);
      ScrollBar->setSmallStep(1);
      ScrollBar->setLargeStep(2 * 1);
    }

    void CGUIScrollText::updateScrollBarSize(s32 size) {
      if (size != ScrollBar->getRelativePosition().getWidth()) {
        core::recti r(RelativeRect.getWidth() - size, 0, RelativeRect.getWidth(), RelativeRect.getHeight());
        ScrollBar->setRelativePosition(r);
      }
    }

    //! destructor
    CGUIScrollText::~CGUIScrollText() {
      if (OverrideFont) {
        OverrideFont->drop();
      }
      if (ScrollBar) {
        ScrollBar->drop();
      }
    }

    //! draws the element and its children
    void CGUIScrollText::draw() {
      if (!IsVisible) {
        return;
      }
      IGUISkin *skin = Environment->getSkin();
      video::IVideoDriver *driver = Environment->getVideoDriver();
      core::rect<s32> frameRect(AbsoluteRect);
      // draw background
      if (Background) {
        if (!OverrideBGColorEnabled) { // skin-colors can change
          BGColor = skin->getColor(gui::EGDC_3D_FACE);
        }
        driver->draw2DRectangle(BGColor, frameRect, &AbsoluteClippingRect);
      }
      // draw the border
      if (Border) {
        skin->draw3DSunkenPane(this, 0, true, false, frameRect, &AbsoluteClippingRect);
        frameRect.UpperLeftCorner.X += skin->getSize(EGDS_TEXT_DISTANCE_X);
      }
      // draw the text
      if (Text.size()) {
        IGUIFont *font = getActiveFont();
        if (font) {
          updateScrollBarSize(skin->getSize(EGDS_SCROLLBAR_SIZE));
          ScrollBar->setMin(0);
          if (!WordWrap) {
            if (VAlign == EGUIA_LOWERRIGHT) {
              frameRect.UpperLeftCorner.Y = frameRect.LowerRightCorner.Y - font->getDimension(L"A").Height - font->getKerningHeight();
            }
            if (HAlign == EGUIA_LOWERRIGHT) {
              frameRect.UpperLeftCorner.X = frameRect.LowerRightCorner.X - font->getDimension(Text.c_str()).Width;
            }
            font->draw(Text, frameRect, getActiveColor(), HAlign == EGUIA_CENTER, VAlign == EGUIA_CENTER, (RestrainTextInside ? &AbsoluteClippingRect : NULL));
          }
          else {
            if (font != LastBreakFont) {
              breakText();
            }
            //~ setVisible(false);
            //~ ScrollBar->setVisible(false);
            core::rect<s32> r = frameRect;
            s32 height = font->getDimension(L"A").Height + font->getKerningHeight();
            s32 totalHeight = height * BrokenText.size();
            ScrollBar->setMax(totalHeight / height - RelativeRect.getHeight() / height);
            if (totalHeight > RelativeRect.getHeight()) {
              ScrollBar->setVisible(true);
            }
            else {
              ScrollBar->setVisible(false);
            }
            if (VAlign == EGUIA_CENTER) {
              r.UpperLeftCorner.Y = r.getCenter().Y - (totalHeight / 2);
            }
            else if (VAlign == EGUIA_LOWERRIGHT) {
              r.UpperLeftCorner.Y = r.LowerRightCorner.Y - totalHeight;
            }
            //~ printf("%d\n", BrokenText.size());
            for (s32 i = 0; i < BrokenText.size(); ++i) {
              if (i >= ScrollBar->getPos()) {
                if (HAlign == EGUIA_LOWERRIGHT) {
                  r.UpperLeftCorner.X = frameRect.LowerRightCorner.X - font->getDimension(BrokenText[i].c_str()).Width;
                }
                font->draw(BrokenText[i], r, getActiveColor(), HAlign == EGUIA_CENTER, false, (RestrainTextInside ? &AbsoluteClippingRect : NULL));
                r.LowerRightCorner.Y += height;
                r.UpperLeftCorner.Y += height;
              }
            }
          }
        }
      }
      else {
        ScrollBar->setVisible(false);
      }
      IGUIElement::draw();
    }

    //! Sets another skin independent font.
    void CGUIScrollText::setOverrideFont(IGUIFont *font) {
      if (OverrideFont == font) {
        return;
      }
      if (OverrideFont) {
        OverrideFont->drop();
      }
      OverrideFont = font;
      if (OverrideFont) {
        OverrideFont->grab();
      }
      breakText();
    }

    //! Gets the override font (if any)
    IGUIFont *CGUIScrollText::getOverrideFont() const {
      return OverrideFont;
    }

    //! Get the font which is used right now for drawing
    IGUIFont *CGUIScrollText::getActiveFont() const {
      if (OverrideFont) {
        return OverrideFont;
      }
      IGUISkin *skin = Environment->getSkin();
      if (skin) {
        return skin->getFont();
      }
      return 0;
    }

    //! Sets another color for the text.
    void CGUIScrollText::setOverrideColor(video::SColor color) {
      OverrideColor = color;
      OverrideColorEnabled = true;
    }

    //! Sets another color for the text.
    void CGUIScrollText::setBackgroundColor(video::SColor color) {
      BGColor = color;
      OverrideBGColorEnabled = true;
      Background = true;
    }

    //! Sets whether to draw the background
    void CGUIScrollText::setDrawBackground(bool draw) {
      Background = draw;
    }

    //! Gets the background color
    video::SColor CGUIScrollText::getBackgroundColor() const {
      return BGColor;
    }

    //! Checks if background drawing is enabled
    bool CGUIScrollText::isDrawBackgroundEnabled() const {
      return Background;
    }

    //! Sets whether to draw the border
    void CGUIScrollText::setDrawBorder(bool draw) {
      Border = draw;
    }

    //! Checks if border drawing is enabled
    bool CGUIScrollText::isDrawBorderEnabled() const {
      return Border;
    }

    void CGUIScrollText::setTextRestrainedInside(bool restrainTextInside) {
      RestrainTextInside = restrainTextInside;
    }

    bool CGUIScrollText::isTextRestrainedInside() const {
      return RestrainTextInside;
    }

    void CGUIScrollText::setTextAlignment(EGUI_ALIGNMENT horizontal, EGUI_ALIGNMENT vertical) {
      HAlign = horizontal;
      VAlign = vertical;
    }

    video::SColor CGUIScrollText::getOverrideColor() const {
      return OverrideColor;
    }

    irr::video::SColor CGUIScrollText::getActiveColor() const {
      if (OverrideColorEnabled) {
        return OverrideColor;
      }
      IGUISkin *skin = Environment->getSkin();
      if (skin) {
        return OverrideColorEnabled ? OverrideColor : skin->getColor(isEnabled() ? EGDC_BUTTON_TEXT : EGDC_GRAY_TEXT);
      }
      return OverrideColor;
    }

    //! Sets if the static text should use the override color or the
    //! color in the gui skin.
    void CGUIScrollText::enableOverrideColor(bool enable) {
      OverrideColorEnabled = enable;
    }

    bool CGUIScrollText::isOverrideColorEnabled() const {
      return OverrideColorEnabled;
    }

    //! Enables or disables word wrap for using the static text as
    //! multiline text control.
    void CGUIScrollText::setWordWrap(bool enable) {
      WordWrap = enable;
      breakText();
    }

    bool CGUIScrollText::isWordWrapEnabled() const {
      return WordWrap;
    }

    void CGUIScrollText::setRightToLeft(bool rtl) {
      if (RightToLeft != rtl) {
        RightToLeft = rtl;
        breakText();
      }
    }

    bool CGUIScrollText::isRightToLeft() const {
      return RightToLeft;
    }

    //! Breaks the single text line.
    void CGUIScrollText::breakText() {
      //~ printf("345\n");
      if (!WordWrap) {
        return;
      }
      BrokenText.clear();
      IGUISkin *skin = Environment->getSkin();
      IGUIFont *font = getActiveFont();
      if (!font) {
        return;
      }
      LastBreakFont = font;
      core::stringw line;
      core::stringw word;
      core::stringw whitespace;
      s32 size = Text.size();
      if (size == 0) {
        return;
      }
      s32 length = 0;
      s32 elWidth = RelativeRect.getWidth();
      if (Border) {
        elWidth -= 2 * skin->getSize(EGDS_TEXT_DISTANCE_X);
      }
      if (ScrollBar->isVisible() and not is_hide_scrollbar) {
        elWidth = elWidth - ScrollBar->getRelativePosition().getWidth();
      }
      wchar_t c;
      // We have to deal with right-to-left and left-to-right differently
      // However, most parts of the following code is the same, it's just
      // some order and boundaries which change.
      if (!RightToLeft) {
        // regular (left-to-right)
        for (s32 i = 0; i < size; ++i) {
          c = Text[i];
          bool lineBreak = false;
          if (c == L'\r') // Mac or Windows breaks
          {
            lineBreak = true;
            if (Text[i + 1] == L'\n') // Windows breaks
            {
              Text.erase(i + 1);
              --size;
            }
            c = '\0';
          }
          else if (c == L'\n') // Unix breaks
          {
            lineBreak = true;
            c = '\0';
          }
          bool isWhitespace = (c == 0);
          if (!isWhitespace) {
            // part of a word
            word += c;
          }
          if (isWhitespace || i == (size - 1) or WordWrap) {
            if (word.size()) {
              // here comes the next whitespace, look if
              // we must break the last word to the next line.
              const s32 whitelgth = font->getDimension(whitespace.c_str()).Width;
              const s32 wordlgth = font->getDimension(word.c_str()).Width;
              if (wordlgth > elWidth) {
                // This word is too long to fit in the available space, look for
                // the Unicode Soft HYphen (SHY / 00AD) character for a place to
                // break the word at
                int where = word.findFirst(wchar_t(0x00AD));
                if (where != -1) {
                  core::stringw first = word.subString(0, where);
                  core::stringw second = word.subString(where, word.size() - where);
                  BrokenText.push_back(line + first + L"-");
                  const s32 secondLength = font->getDimension(second.c_str()).Width;
                  length = secondLength;
                  line = second;
                }
                else {
                  // No soft hyphen found, so there's nothing more we can do
                  // break to next line
                  if (length) {
                    BrokenText.push_back(line);
                  }
                  length = wordlgth;
                  line = word;
                }
              }
              else if (length && (length + wordlgth + whitelgth > elWidth)) {
                // break to next line
                BrokenText.push_back(line);
                length = wordlgth;
                line = word;
              }
              else {
                // add word to line
                line += whitespace;
                line += word;
                length += whitelgth + wordlgth;
              }
              word = L"";
              whitespace = L"";
            }
            if (isWhitespace) {
              whitespace += c;
            }
            // compute line break
            if (lineBreak) {
              line += whitespace;
              line += word;
              BrokenText.push_back(line);
              line = L"";
              word = L"";
              whitespace = L"";
              length = 0;
            }
          }
        }
        line += whitespace;
        line += word;
        BrokenText.push_back(line);
      }
      else {
        // right-to-left
        for (s32 i = size; i >= 0; --i) {
          c = Text[i];
          bool lineBreak = false;
          if (c == L'\r') // Mac or Windows breaks
          {
            lineBreak = true;
            if ((i > 0) && Text[i - 1] == L'\n') // Windows breaks
            {
              Text.erase(i - 1);
              --size;
            }
            c = '\0';
          }
          else if (c == L'\n') // Unix breaks
          {
            lineBreak = true;
            c = '\0';
          }
          if (c == L' ' || c == 0 || i == 0) {
            if (word.size()) {
              // here comes the next whitespace, look if
              // we must break the last word to the next line.
              const s32 whitelgth = font->getDimension(whitespace.c_str()).Width;
              const s32 wordlgth = font->getDimension(word.c_str()).Width;
              if (length && (length + wordlgth + whitelgth > elWidth)) {
                // break to next line
                BrokenText.push_back(line);
                length = wordlgth;
                line = word;
              }
              else {
                // add word to line
                line = whitespace + line;
                line = word + line;
                length += whitelgth + wordlgth;
              }
              word = L"";
              whitespace = L"";
            }
            if (c != 0) {
              whitespace = core::stringw(&c, 1) + whitespace;
            }
            // compute line break
            if (lineBreak) {
              line = whitespace + line;
              line = word + line;
              BrokenText.push_back(line);
              line = L"";
              word = L"";
              whitespace = L"";
              length = 0;
            }
          }
          else {
            // yippee this is a word..
            word = core::stringw(&c, 1) + word;
          }
        }
        line = whitespace + line;
        line = word + line;
        BrokenText.push_back(line);
      }
      ScrollBar->setPos(0);
      if (((BrokenText.size() + 1) * (font->getDimension(L"A").Height + font->getKerningHeight())) > RelativeRect.getHeight() and not ScrollBar->isVisible() and not is_hide_scrollbar) {
        
        ScrollBar->setVisible(true);
        return breakText();
      }
    }

    //! Sets the new caption of this element.
    void CGUIScrollText::setText(const wchar_t *text) {
      updateScrollBarSize(Environment->getSkin()->getSize(EGDS_SCROLLBAR_SIZE));
      ScrollBar->setVisible(false);
      IGUIElement::setText(text);
      breakText();
    }

    void CGUIScrollText::updateAbsolutePosition() {
      IGUIElement::updateAbsolutePosition();
    }

    //! Returns the height of the text in pixels when it is drawn.
    s32 CGUIScrollText::getTextHeight() const {
      IGUIFont *font = getActiveFont();
      if (!font) {
        return 0;
      }
      if (WordWrap) {
        s32 height = font->getDimension(L"A").Height + font->getKerningHeight();
        //~ printf("%d\n", height);
        //~ printf("%d\n", BrokenText.size());
        //~ printf("%d\n\n", height * BrokenText.size());
        return height * BrokenText.size();
      }
      else {
        // TODO: Text can have multiple lines which are not in BrokenText
        // This is likely not correct. But as I have no time for further
        // investigation I just fix it for now by return the true height here.
        return font->getDimension(Text.c_str()).Height;
      }
    }

    s32 CGUIScrollText::getTextWidth() const {
      IGUIFont *font = getActiveFont();
      if (!font) {
        return 0;
      }
      if (WordWrap) {
        s32 widest = 0;
        for (u32 line = 0; line < BrokenText.size(); ++line) {
          s32 width = font->getDimension(BrokenText[line].c_str()).Width;
          if (width > widest) {
            widest = width;
          }
        }
        return widest;
      }
      else {
        return font->getDimension(Text.c_str()).Width;
      }
    }

    core::stringw CGUIScrollText::joinStrings(const core::array<core::stringw> &strings, const core::stringw &delimiter) {
      core::stringw result;
      for (u32 i = 0; i < strings.size(); ++i) {
        if (i != 0) {
          result += delimiter; // 添加分隔符（可选）
        }
        result += strings[i].c_str();
      }
      return result;
    }

    void CGUIScrollText::setToolTipBrokenText() {
      ToolTipText = joinStrings(BrokenText);
    }

    bool CGUIScrollText::OnEvent(const SEvent &event) {
      if (ScrollBar->isVisible() && !m_isHandlingEvent and not Environment->hasFocus(ScrollBar)) {
        if (event.MouseInput.Event == EMIE_MOUSE_WHEEL or event.EventType == EET_KEY_INPUT_EVENT) {
          m_isHandlingEvent = true; // 标记正在处理
          Environment->setFocus(ScrollBar);
          ScrollBar->OnEvent(event);
          m_isHandlingEvent = false; // 重置标记
          return true;
        }
      }
      return IGUIElement::OnEvent(event);
    }

  } // end namespace gui
} // end namespace irr
#endif // _IRR_COMPILE_WITH_GUI_
