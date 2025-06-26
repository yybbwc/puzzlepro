// (c) 2015-2019 Nicolaus Anderson

//~ #ifndef GUI_FILE_SELECT_PANEL_CPP
//~ #define GUI_MATERIAL_PANEL_CPP

#pragma once

#include "file_list.h"

#include "CGUIFileSelectPanel.h"
#include <irrArray.h>
#include <IGUIEnvironment.h>
#include <CFileSystem.h>
#include <CFileList.h>
#include <locale.h>
//~ #include <os.h> // needed for locale
#include <IGUIButton.h>
#include <IGUIListBox.h>
#include <IGUIEditBox.h>
#include <vector>

#include "IrrCompileConfig.h"

//~ #include "CFileSystem.h"
#include "IReadFile.h"
#include "IWriteFile.h"
#include "CZipReader.h"
#include "CMountPointReader.h"
#include "CPakReader.h"
#include "CNPKReader.h"
#include "CTarReader.h"
#include "CWADReader.h"
#include "CFileList.h"
#include "CXMLReader.h"
#include "CXMLWriter.h"
#include "stdio.h"
#include "os.h"
#include "CAttributes.h"
#include "CReadFile.h"
#include "CMemoryFile.h"
#include "CLimitReadFile.h"
#include "CWriteFile.h"
#include "irrList.h"

#if defined(__STRICT_ANSI__)
#error Compiling with __STRICT_ANSI__ not supported. g++ does set this when compiling with -std=c++11 or -std=c++0x. Use instead -std=gnu++11 or -std=gnu++0x. Or use -U__STRICT_ANSI__ to disable strict ansi.
#endif

#if defined(_IRR_WINDOWS_API_)
#if !defined(_WIN32_WCE)
#include <direct.h> // for _chdir
#include <io.h>     // for _access
#include <tchar.h>
#endif
#else
#if (defined(_IRR_POSIX_API_) || defined(_IRR_OSX_PLATFORM_))
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#endif
#endif

namespace irr {
  namespace gui {

    using core::dimension2di;
    using core::string;
    using core::vector2di;

    CGUIFileSelectPanel::CGUIFileSelectPanel(IGUIEnvironment *pEnvironment, IGUIElement *pParent, recti pRect, s32 id) : IGUIElement(EGUIET_ELEMENT, pEnvironment, pParent, id, pRect), fileSystem(0), fileList(0), filesIndex(), selectButton(0), cancelButton(0), fileListBox(0), fileNameEditBox(0), isFileSelectedFromList(false), lastFileSelectPanelEvent(EGFSPE_NONE), notifyWhenEditBoxChanges(false), restoreDirWhenDone(true), restoreDirWhenCancelled(true), initialWorkingDir(), currentWorkingDir(), drawBack(true) {
      //~ CGUIFileSelectPanel::CGUIFileSelectPanel(IGUIEnvironment* pEnvironment, IGUIElement* pParent, recti pRect, s32 id) : IGUIElement(EGUIET_ELEMENT, pEnvironment, pParent, id, pRect), fileSystem(0), fileList(0), filesIndex(), selectButton(0), fileListBox(0), fileNameEditBox(0), isFileSelectedFromList(false), lastFileSelectPanelEvent(EGFSPE_NONE), notifyWhenEditBoxChanges(false), restoreDirWhenDone(true), restoreDirWhenCancelled(true), initialWorkingDir(), currentWorkingDir(), drawBack(true) {
      fileSystem = Environment->getFileSystem();
      //~ fileSystem = new irr::io::CFileSystem();
      fileSystem->grab();
      //~ fileSystem->setFileListSystem(io::FILESYSTEM_VIRTUAL);

      //~ f32 button_width_ratio = 0.15;
      //~ f32 gap_ratio = 0.02;
      //~ s32 margin = pRect.getWidth() * ;

      //~ const IGUISkin* skin = Environment->getSkin();

      //~ const s32 buttonHeight = skin->getSize(EGDS_BUTTON_HEIGHT);
      //~ const s32 buttonWidth = skin->getSize(EGDS_BUTTON_WIDTH);
      //~ const s32 titleHeight = skin->getSize(EGDS_WINDOW_BUTTON_WIDTH) + 2; // titlebar has no own constant
      //~ const s32 buttonDistance = skin->getSize(EGDS_WINDOW_BUTTON_WIDTH);
      //~ const s32 borderWidth = skin->getSize(EGDS_MESSAGE_BOX_GAP_SPACE);

      //~ auto borderHeight = borderWidth;

      //~ s32 buttonBoxHeight = buttonHeight + 2 * borderHeight;

      //~ core::rect<s32> staticRect;
      //~ staticRect.UpperLeftCorner.X = borderWidth;
      //~ staticRect.UpperLeftCorner.Y = titleHeight + borderWidth;
      //~ staticRect.LowerRightCorner.X = RelativeRect.getWidth() - borderWidth;
      //~ staticRect.LowerRightCorner.Y = RelativeRect.getHeight() - borderHeight - buttonBoxHeight;

      //~ recti selectButtonRect(vector2di(pRect.getWidth() - 130, pRect.getHeight() - 25), dimension2di(60, 20));
      //~ recti selectButtonRect(vector2di(pRect.getWidth() - 130, pRect.getHeight() - 25), dimension2di(60, 20));
      //~ recti selectButtonRect(vector2di(pRect.getWidth() * 0.05, pRect.getHeight() - 25), dimension2di(pRect.getWidth() * 0.4, 20));
      //~ recti selectButtonRect(vector2di(pRect.getWidth() - 130, pRect.getHeight() - 25), dimension2di(pRect.getWidth() * button_width_ratio, 20));
      //~ auto selectButtonRect = core::rect<s32>(pRect);
      //~ selectButton = Environment->addButton(selectButtonRect, this, -1, L"Select", L"Confirm file name");
      //~ selectButton->setAlignment(EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT);
      //~ selectButton->setAlignment(EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT, EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT);
      //~ selectButton->setSubElement(true);
      //~ selectButton->grab();

      //~ recti cancelButtonRect(vector2di(pRect.getWidth() * (button_width_ratio + gap_ratio), pRect.getHeight() - 25), dimension2di(pRect.getWidth() * button_width_ratio, 20));
      //~ recti cancelButtonRect(vector2di(pRect.getWidth() - 65, pRect.getHeight() - 25), dimension2di(60, 20));
      //~ recti cancelButtonRect(vector2di(pRect.getWidth() * 0.55, pRect.getHeight() - 25), dimension2di(pRect.getWidth() * 0.4, 20));
      //~ recti cancelButtonRect(vector2di(pRect.getWidth() - 65, pRect.getHeight() - buttonHeight - borderHeight), dimension2di(60, buttonHeight));
      //~ auto cancelButtonRect = core::rect<s32>(pRect);
      //~ cancelButton = Environment->addButton(cancelButtonRect, this, -1, L"Cancel");
      //~ cancelButton->setAlignment(EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT);
      //~ cancelButton->setSubElement(true);
      //~ cancelButton->grab();

      //~ core::rect<s32> fileListRect;
      //~ fileListRect.UpperLeftCorner.X = borderWidth;
      //~ fileListRect.UpperLeftCorner.Y = titleHeight + borderWidth;
      //~ fileListRect.LowerRightCorner.X = pRect.getWidth() - borderWidth;
      //~ fileListRect.LowerRightCorner.Y = pRect.getHeight() - borderHeight - buttonBoxHeight * 2;

      auto fileListRect = core::rect<s32>(pRect);
      //~ recti fileListRect(5, 5, pRect.getWidth() - 5, pRect.getHeight() - 55);
      fileListBox = Environment->addListBox(fileListRect, this, -1, true);
      //~ fileListBox->setAlignment(EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT, EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT);
      fileListBox->setSubElement(true);
      fileListBox->grab();

      auto fileNameEditRect = core::rect<s32>(pRect);
      //~ recti fileNameEditRect(5, pRect.getHeight() - 50, pRect.getWidth() - 5, pRect.getHeight() - 30);
      fileNameEditBox = Environment->addEditBox(L"", fileNameEditRect, true, this, -1);
      //~ fileNameEditBox->setAlignment(EGUIA_UPPERLEFT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT, EGUIA_LOWERRIGHT);
      fileNameEditBox->setSubElement(true);
      fileNameEditBox->grab();

      //~ initialWorkingDir = fileSystem->getAbsolutePath(fileSystem->getWorkingDirectory());
      //~ if (pStartDirectory.size()) {
      //~ fileSystem->changeWorkingDirectoryTo(pStartDirectory);
      //~ currentWorkingDir = pStartDirectory;
      //~ }
      //~ else {
      //~ currentWorkingDir = initialWorkingDir;
      //~ }
      //~ fillFileList();
    }

    void CGUIFileSelectPanel::setButtonText(const wchar_t *text_1, const wchar_t *text_2) {
      selectButton->setText(text_1);
      cancelButton->setText(text_2);
    }

    CGUIFileSelectPanel::~CGUIFileSelectPanel() {
      // if ( restoreDirWhenDone )
      //	fileSystem->changeWorkingDirectoryTo( initialWorkingDir );

      //~ if (selectButton) {
      //~ selectButton->drop();
      //~ }
      //~ if (cancelButton) {
      //~ cancelButton->drop();
      //~ }
      if (fileListBox) {
        fileListBox->drop();
      }
      if (fileNameEditBox) {
        fileNameEditBox->drop();
      }

      fileSystem->drop();
    }

    IGUIButton *CGUIFileSelectPanel::getSelectButton() {
      return selectButton;
    }

    IGUIButton *CGUIFileSelectPanel::getCancelButton() {
      return cancelButton;
    }

    bool CGUIFileSelectPanel::OnEvent(const SEvent &event) {
      if (event.EventType != EET_GUI_EVENT) {
        return false;
      }

      /*
      How this should work:
      Typing in an edit-box filters the list to show only matches unless
      the editbox value is "", in which case, everything is shown.
      The file selected is set to the file name.

      isSelectedFileReal() indicates if the selected file is taken from the list.
      */

      /*
      DO NOT RESTORE THE DIRECTORY AFTER SELECTION.
      It doesn't make sense to restore the directory before the file path has been obtained by the user.
      EDIT:
      I can change this if I use getFullFileName() from the fileList, which saves the directory.
      */

      switch (event.GUIEvent.EventType) {
        case EGET_BUTTON_CLICKED:
          if (event.GUIEvent.Caller == selectButton) {
            lastFileSelectPanelEvent = EGFSPE_FILE_CONFIRMED;
            sendGUIEvent(EGET_FILE_SELECTED);
            //~ if (restoreDirWhenDone) {
            //~ fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
            //~ }
            return true;
          }
          else if (event.GUIEvent.Caller == cancelButton) {
            lastFileSelectPanelEvent = EGFSPE_CANCEL;
            sendGUIEvent(EGET_FILE_CHOOSE_DIALOG_CANCELLED);
            //~ if (restoreDirWhenCancelled) {
            //~ fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
            //~ }
            return true;
          }
          break;

        case EGET_EDITBOX_CHANGED:
          if (event.GUIEvent.Caller == fileNameEditBox) {
            isFileSelectedFromList = false;
            fillFileList();
            //~ if (notifyWhenEditBoxChanges) {
            //~ sendGUIEvent(EGET_EDITBOX_CHANGED, fileNameEditBox);
            //~ }
            return true;
          }
          break;

        case EGET_EDITBOX_ENTER: // another means of selection
          if (event.GUIEvent.Caller == fileNameEditBox) {
            // confirm file selection
            lastFileSelectPanelEvent = EGFSPE_FILE_CONFIRMED;
            // sendGUIEvent( EGET_EDITBOX_ENTER, fileNameEditBox ); // Doesn't allow file_selected filtering in parent OnEvent
            sendGUIEvent(EGET_FILE_SELECTED);
            //~ if (restoreDirWhenDone) {
            //~ fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
            //~ }
            return true;
          }
          break;

        case EGET_LISTBOX_CHANGED:
          if (event.GUIEvent.Caller == fileListBox) {
            isFileSelectedFromList = true;
            lastFileSelectPanelEvent = EGFSPE_REAL_FILE_SELECTED;
            // sendGUIEvent( EGET_LISTBOX_CHANGED, fileListBox ); // Doesn't allow file_selected filtering in parent OnEvent
            sendGUIEvent(EGET_FILE_SELECTED);
            //~ setToolTipText(L"4353456");
            return true;
          }
          break;

        case EGET_LISTBOX_SELECTED_AGAIN:
          if (event.GUIEvent.Caller == fileListBox) {
            // confirm file selection
            lastFileSelectPanelEvent = EGFSPE_FILE_CONFIRMED;
            if (isSelectedFileReal()) {
              // sendGUIEvent( EGET_LISTBOX_SELECTED_AGAIN, fileListBox ); // Doesn't allow file_selected filtering in parent OnEvent
              sendGUIEvent(EGET_FILE_SELECTED);
              //~ if (restoreDirWhenDone) {
              //~ fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
              //~ }
              return true;
            }
            else {
              // Selected is real (since it's in the list), but it is a directory
              //~ setToolTipText(L"1");
              openSelectedDirectory();
            }
          }
          break;

        default:
          break;
      }

      return false;
    }

    EGUIFileSelectPanelEvent CGUIFileSelectPanel::getLastEvent() {
      return lastFileSelectPanelEvent;
    }

    void CGUIFileSelectPanel::sendGUIEvent(EGUI_EVENT_TYPE pEventType, IGUIElement *pElement) {
      SEvent event;
      event.EventType = EET_GUI_EVENT;
      event.GUIEvent.Caller = this;
      event.GUIEvent.Element = pElement;
      event.GUIEvent.EventType = pEventType;

      if (Parent) {
        Parent->OnEvent(event);
      }
    }

    void CGUIFileSelectPanel::setNotifyWhenEditBoxChanges(bool yes) {
      notifyWhenEditBoxChanges = yes;
    }

    io::path CGUIFileSelectPanel::getCurrentWorkingDirectory() {
      fileSystem->flattenFilename(currentWorkingDir);
      return currentWorkingDir;
    }

    bool CGUIFileSelectPanel::isSelectedReal() {
      return isFileSelectedFromList;
    }

    bool CGUIFileSelectPanel::isSelectedFileReal() {
      // Must be selected from list and not be a directory
      if (isFileSelectedFromList) {
        for (u32 i = 0; i < fileList->getFileCount(); i++) {
          if (fileList->getFileName(i) == fileListBox->getListItem(fileListBox->getSelected())) {
            return !(fileList->isDirectory(i));
          }
        }
      }
      return false;
    }

    io::path CGUIFileSelectPanel::getSelectedFile() {
      if (isFileSelectedFromList) {
        //~ fast_io::io::print(fast_io::win32_box_t(), isFileSelectedFromList, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
        //~ fast_io::io::print(fast_io::win32_box_t(), fast_io::mnp::code_cvt_os_c_str(fileList->getFileName(getSelectedFileIndex()).c_str()), "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
        return fileList->getFileName(getSelectedFileIndex());
      }
      io::path filename = fileNameEditBox->getText();
      fileSystem->flattenFilename(filename);
      return filename;
    }

    io::path CGUIFileSelectPanel::getSelectedFilePath() {
      //~ setToolTipText(stringw(fileList->getFileCount()).c_str());

      if (fileListBox->getItemCount() == 1) {
        //~ io::path path = fileSystem->getAbsolutePath(fileListBox->getListItem(0));
        //~ if (fileSystem->isDirectory(path)) {

        //~ }
        //~ else {
        //~ return path
        //~ }
        fileListBox->setSelected(0);
        isFileSelectedFromList = true;
        //~ fast_io::io::print(fast_io::win32_box_t(), isFileSelectedFromList, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      }
      if (isFileSelectedFromList) {
        //~ fast_io::io::print(fast_io::win32_box_t(), isFileSelectedFromList, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
        //~ fast_io::io::print(fast_io::win32_box_t(), getSelectedFileIndex(), "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
        //~ fast_io::io::print(fast_io::win32_box_t(), fast_io::mnp::code_cvt_os_c_str(fileList->getFullFileName(getSelectedFileIndex()).c_str()), "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
        return fileList->getFullFileName(getSelectedFileIndex());
      }
      //~ fast_io::io::print(fast_io::win32_box_t(), isFileSelectedFromList, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      return fileSystem->getAbsolutePath(getSelectedFile());
    }

    io::path CGUIFileSelectPanel::getSelectedFileRelativePath() {
      return fileSystem->getRelativeFilename(getSelectedFilePath(), initialWorkingDir);
    }

    io::path CGUIFileSelectPanel::getSelectedFileFullName() {
      return fileSystem->getFileBasename(getSelectedFilePath());
    }

    //! Restore the working directory to the initial directory when a file is selected
    void CGUIFileSelectPanel::setRestoreDirectoryWhenDone(bool yes) {
      restoreDirWhenDone = yes;
    }

    //! Restore the working directory to the initial directory when cancelling
    void CGUIFileSelectPanel::setRestoreDirectoryWhenCancelled(bool yes) {
      restoreDirWhenCancelled = yes;
    }

    void CGUIFileSelectPanel::reactivate() {
      fileSystem->changeWorkingDirectoryTo(currentWorkingDir);
    }

    void CGUIFileSelectPanel::deactivate() {
      fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
    }

    s32 CGUIFileSelectPanel::getSelectedFileIndex() {
      return filesIndex[fileListBox->getSelected()];
    }

    void CGUIFileSelectPanel::openSelectedDirectory() {
      const io::path entry = fileList->getFileName(getSelectedFileIndex());
      if (entry.size() > 0) {
        //~ bool should_to;
        //~ auto k1 = fileSystem->getAbsolutePath(currentWorkingDir);
        //~ auto k2 = fileSystem->getAbsolutePath(initialWorkingDir);
        //~ should_to = (fileSystem->flattenFilename(k1) == fileSystem->flattenFilename(k2));
        //~ should_to = !(should_to and entry == L"..");
        //~ if (should_to) {
        //~ printf("%ls", entry.c_str());
          currentWorkingDir = fileSystem->getAbsolutePath(currentWorkingDir) + L"/" + entry;
          fillFileList();
        //~ }
      }
    }

    void CGUIFileSelectPanel::pathToStringW(irr::core::stringw &result, const irr::io::path &p) {
      // Taken from Irrlicht trunk 5823, probably added by CuteAlien.
      //~ #ifndef _IRR_WCHAR_FILESYSTEM
      //~ char *oldLocale = setlocale(LC_CTYPE, NULL);
      //~ setlocale(LC_CTYPE, ""); // multibyteToWString is affected by LC_CTYPE. Filenames seem to need the system-locale.
      //~ core::multibyteToWString(result, p);
      //~ setlocale(LC_CTYPE, oldLocale);
      //~ #else
      result = p.c_str();
      //~ #endif
    }

    void CGUIFileSelectPanel::fillFileList() {
#if !defined(_IRR_WINDOWS_CE_PLATFORM_)
      setlocale(LC_ALL, "");
#endif

      if (fileList) {
        fileList->drop();
        fileList = 0;
      }

      fileList = createFileList();

      if (!fileList) { // FIXME: Should throw, but this should also never happen
        return;
      }

      filesIndex.clear();
      fileListBox->clear();
      s32 folderIcon = Environment->getSkin()->getIcon(EGDI_DIRECTORY);
      s32 fileIcon = Environment->getSkin()->getIcon(EGDI_FILE);
      stringw filterText(fileNameEditBox->getText());
      stringw fileNameTemp;

      for (s32 i = 0; i < fileList->getFileCount(); i++) {
        pathToStringW(fileNameTemp, fileList->getFileName(i));
        //~ setToolTipText(fileList->getFileName(i).c_str());
        //~ if (filterText.size() < 0) {
        //~ }
        //~ else {
        //~ if (fileNameTemp.subString(0, filterText.size()).make_lower() == filterText.make_lower()) {
        //~ bool shouldAdd = (filterText.size() == 0);
        //~ shouldAdd = shouldAdd or (fileNameTemp.make_lower().find(filterText.make_lower().c_str()) != -1);
        //~ if (shouldAdd) {
        //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
        //~ filesIndex.push_back(i);
        //~ }
        //~ shouldAdd = (filterText.size() == 0)
        //~ if (filterText.size() == 0) {
        //~ addItem(fileNameTemp, i);
        //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
        //~ filesIndex.push_back(i);
        //~ }
        //~ else if (fileNameTemp.make_lower().find(filterText.make_lower().c_str()) != -1) {
        //~ addItem(fileNameTemp, i);
        //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
        //~ filesIndex.push_back(i);
        //~ }
        //~ if (fileNameTemp.make_lower().find(filterText.make_lower().c_str()) != -1) {
        //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
        //~ filesIndex.push_back(i);
        //~ }
        //~ }
        // 在类的成员函数中调用
        if (containsAllKeywords(fileNameTemp, filterText)) {
          if (fileNameTemp == L".") {
          }
          else {
            if (endsWithIgnoreCase(fileNameTemp, filterSuffix) or fileList->isDirectory(i)) {

              fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
              filesIndex.push_back(i);
            }
          }
        }
        //~ if (filterText.size() == 0 || (filterText.size() > 0 && fileNameTemp.subString(0, filterText.size()) == filterText)) {
        //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(i) ? folderIcon : 0));
        //~ filesIndex.push_back(i);
        //~ }
      }
    }

    bool CGUIFileSelectPanel::endsWithIgnoreCase(const io::path &p, const io::path &suffix) {
      if (p.size() < suffix.size()) {
        return false;
      }
      return p.equals_substring_ignore_case(suffix.c_str(), p.size() - suffix.size());
    }

    void CGUIFileSelectPanel::setWorkingDir(const wchar_t *o1, const const wchar_t *o2) {
      fileNameEditBox->setText(L"");
      currentWorkingDir = o1;
      initialWorkingDir = currentWorkingDir;
      //~ lastWorkingDir = currentWorkingDir;
      //~ initialWorkingDir = initialWorkingDir + L"/.";

      filterSuffix = o2;
      //~ fileSystem->changeWorkingDirectoryTo(initialWorkingDir);
      fillFileList();
    }

    // 在 CGUIFileSelectPanel.cpp 中实现
    bool CGUIFileSelectPanel::containsAllKeywords(const irr::core::stringw &str, const irr::core::stringw &filter) {
      if (filter.empty()) {
        return true;
      }

      // 分割关键词
      std::vector<irr::core::stringw> keywords;
      irr::core::stringw currentKeyword;
      for (u32 i = 0; i < filter.size(); ++i) {
        wchar_t c = filter[i];
        if (c == L' ') {
          if (!currentKeyword.empty()) {
            keywords.push_back(currentKeyword);
            currentKeyword.clear();
          }
        }
        else {
          currentKeyword += c;
        }
      }
      if (!currentKeyword.empty()) {
        keywords.push_back(currentKeyword);
      }

      // 转换为小写
      irr::core::stringw lowerStr = str;
      lowerStr.make_lower();
      for (auto &keyword : keywords) {
        keyword.make_lower();
        if (lowerStr.find(keyword.c_str()) == -1) {
          return false;
        }
      }
      return true;
    }

    //~ void addItem(stringw o1, s32 o2) {
    //~ fileListBox->addItem(fileNameTemp.c_str(), (fileList->isDirectory(o2) ? folderIcon : 0));
    //~ filesIndex.push_back(o2);
    //~ }

    void CGUIFileSelectPanel::draw() {
      if (drawBack) {
        Environment->getSkin()->draw3DSunkenPane(this, Environment->getSkin()->getColor(EGDC_3D_FACE), true, true, AbsoluteRect, &AbsoluteClippingRect);
      }

      //~ // 假设 pRect = recti(0, 0, 400, 300)
      //~ const int margin = 15;  // 边距
      //~ const int controlHeight = 30;  // 控件高度

      //~ // 顶部文件列表（占60%空间）
      //~ fileListBox->setRelativePosition(recti(
      //~ margin,
      //~ margin,
      //~ RelativeRect.getWidth() - margin,
      //~ RelativeRect.getHeight()*0.6 - margin/2
      //~ ));

      //~ // 中部文件名输入（黄金分割位置）
      //~ fileNameEditBox->setRelativePosition(recti(
      //~ margin,
      //~ RelativeRect.getHeight()*0.6 + margin/2,
      //~ RelativeRect.getWidth() - margin,
      //~ RelativeRect.getHeight()*0.6 + controlHeight + margin/2
      //~ ));

      //~ // 底部按钮组（右对齐）
      //~ const int buttonWidth = 80;
      //~ selectButton->setRelativePosition(recti(
      //~ RelativeRect.getWidth() - margin - 2*buttonWidth - 10,
      //~ RelativeRect.getHeight() - margin - controlHeight,
      //~ RelativeRect.getWidth() - margin - buttonWidth - 10,
      //~ RelativeRect.getHeight() - margin
      //~ ));

      //~ cancelButton->setRelativePosition(recti(
      //~ RelativeRect.getWidth() - margin - buttonWidth,
      //~ RelativeRect.getHeight() - margin - controlHeight,
      //~ RelativeRect.getWidth() - margin,
      //~ RelativeRect.getHeight() - margin
      //~ ));

      //~ // 视觉舒适度参数（基于EM单位换算）
      //~ const int visualUnit = controlHeight * 0.8; // 以控件高度为基准单位
      //~ const int groupSpacing = visualUnit * 0.618; // 黄金分割间距
      //~ const int elementSpacing = visualUnit * 0.382; // 次级间距

      //~ // 文件列表（保持原有高度，确保信息量）
      //~ fileListBox->setRelativePosition(recti(
      //~ margin,
      //~ margin,
      //~ RelativeRect.getWidth() - margin,
      //~ RelativeRect.getHeight() - 3*controlHeight - groupSpacing
      //~ ));

      //~ // 文件名编辑框+按钮组（视觉耦合区块）
      //~ const int inputBlockY = RelativeRect.getHeight() - 3*controlHeight - elementSpacing;

      //~ // 文件名编辑框（与按钮形成视觉关联）
      //~ fileNameEditBox->setRelativePosition(recti(
      //~ margin,
      //~ inputBlockY,
      //~ RelativeRect.getWidth() - 2*buttonWidth - 3*margin, // 为按钮预留空间
      //~ inputBlockY + controlHeight
      //~ ));

      //~ // 按钮组（与编辑框垂直中线对齐）
      //~ const int buttonY = inputBlockY + (controlHeight - buttonHeight)/2; // 垂直居中
      //~ selectButton->setRelativePosition(recti(
      //~ fileNameEditBox->getRelativePosition().LowerRightCorner.X + margin,
      //~ buttonY,
      //~ fileNameEditBox->getRelativePosition().LowerRightCorner.X + margin + buttonWidth,
      //~ buttonY + buttonHeight
      //~ ));

      //~ cancelButton->setRelativePosition(recti(
      //~ selectButton->getRelativePosition().LowerRightCorner.X + elementSpacing,
      //~ buttonY,
      //~ selectButton->getRelativePosition().LowerRightCorner.X + elementSpacing + buttonWidth,
      //~ buttonY + buttonHeight
      //~ ));

      // 基础参数定义（基于父窗口尺寸动态计算）
      //~ const int baseUnit = RelativeRect.getHeight() / 24; // 使用24分割法
      //~ const int margin = baseUnit * 1.5;           // 基础边距
      //~ const int controlHeight = baseUnit * 2;      // 标准控件高度
      //~ const int buttonWidth = baseUnit * 8;        // 按钮基准宽度
      //~ const int buttonHeight = controlHeight * 0.9;// 按钮稍矮于编辑框

      //~ s32 width = RelativeRect.getWidth();
      //~ s32 height = RelativeRect.getHeight();
      //~ s32 grid_number = 24;
      //~ s32 grid_width = width / grid_number;
      //~ s32 grid_height = height / grid_number;
      //~ s32 grid = 24;

      //~ // 文件列表（占60%垂直空间）
      //~ fileListBox->setRelativePosition(recti(
      //~ width * 1 / grid,
      //~ height * 1 / grid,
      //~ width * 23 / grid,
      //~ height * 14 / grid
      //~ ));

      //~ fileNameEditBox->setRelativePosition(recti(
      //~ width * 1 / grid,
      //~ height * 15 / grid,
      //~ width * 23 / grid, // 动态计算
      //~ height * 17 / grid
      //~ ));

      //~ selectButton->setRelativePosition(recti(
      //~ width * 1 / grid,
      //~ height * 18 / grid,
      //~ width * 23 / grid,
      //~ height * 20 / grid
      //~ ));

      //~ cancelButton->setRelativePosition(recti(
      //~ width * 1 / grid, // 紧凑间距
      //~ height * 21 / grid,
      //~ width * 23 / grid,
      //~ height * 23 / grid
      //~ ));

      //~ fileListBox->setRelativePositionProportional(core::rect<f32>(
      //~ 0.05f,   // Left: 5% 边距
      //~ 0.05f,   // Top: 5% 边距
      //~ 0.95f,   // Right: 95% 边距
      //~ 0.95f    // Bottom: 65% 高度（占60%空间）
      //~ ));
      f32 grid = 50;

      //~ fileListBox->setRelativePositionProportional(core::rect<f32>( 1 / grid, 1 / grid, 49 / grid, 39 / grid));
      //~ fileNameEditBox->setRelativePositionProportional(core::rect<f32>( 1 / grid, 40 / grid, 49 / grid, 44 / grid));
      //~ selectButton->setRelativePositionProportional(core::rect<f32>( 1 / grid, 45 / grid, 24 / grid, 49 / grid));
      //~ cancelButton->setRelativePositionProportional(core::rect<f32>( 26 / grid, 45 / grid, 49 / grid, 49 / grid));

      //~ fileListBox->setRelativePositionProportional(core::rect<f32>( 1 / grid, 1 / grid, 49 / grid, 44 / grid));
      //~ fileNameEditBox->setRelativePositionProportional(core::rect<f32>( 1 / grid, 45 / grid, 49 / grid, 49 / grid));

      fileListBox->setRelativePositionProportional(core::rect<f32>(1 / grid, 1 / grid, 49 / grid, 44 / grid));
      fileNameEditBox->setRelativePositionProportional(core::rect<f32>(1 / grid, 45 / grid, 49 / grid, 49 / grid));

      IGUIElement::draw();
    }

    //~ void CGUIFileSelectPanel::serializeAttributes(irr::io::IAttributes* out, irr::io::SAttributeReadWriteOptions* options) {
    //~ out->addBool("RestoreStartDirectoryWhenDone", restoreDirWhenDone);
    //~ out->addBool("RestoreStartDirectoryWhenCancelled", restoreDirWhenCancelled);
    //~ #ifndef _IRR_WCHAR_FILESYSTEM
    //~ out->addString("InitialWorkingDirectory", initialWorkingDir.c_str());
    // TODO: Wait... shouldn't this be switched with the other one
    //~ #else
    //~ out->addStringW("InitialWorkingDirectory", initialWorkingDir.c_str());
    //~ #endif
    //~ out->addBool("DrawBack", drawBack);
    //~ }

    //~ void CGUIFileSelectPanel::deserializeAttributes(irr::io::IAttributes* in, irr::io::SAttributeReadWriteOptions* options) {
    //~ restoreDirWhenDone = in->getAttributeAsBool("RestoreStartDirectoryWhenDone", restoreDirWhenDone);
    //~ restoreDirWhenCancelled = in->getAttributeAsBool("RestoreStartDirectoryWhenCancelled", restoreDirWhenCancelled);
    //~ if (in->existsAttribute("InitialWorkingDirectory")) {
    //~ #ifndef _IRR_WCHAR_FILESYSTEM
    //~ initialWorkingDir = in->getAttributeAsString("InitialWorkingDirectory", initialWorkingDir.c_str());
    // TODO: Wait... shouldn't this be switched with the other one
    //~ #else
    //~ initialWorkingDir = in->getAttributeAsStringW("InitialWorkingDirectory", initialWorkingDir.c_str());
    //~ #endif
    //~ }
    //~ drawBack = in->getAttributeAsBool("DrawBack", drawBack);
    //~ }

    //! Creates a list of files and directories in the current working directory
    io::file_list *CGUIFileSelectPanel::createFileList() {
      io::file_list *r = 0;
      //~ io::path Path = fileSystem->getWorkingDirectory();
      io::path Path = fileSystem->getAbsolutePath(currentWorkingDir);
      //~ setToolTipText(Path.c_str());
      Path.replace('\\', '/');
      if (!Path.empty() && Path.lastChar() != '/') {
        Path.append('/');
      }

      //! Construct from native filesystem
      //~ if (FileSystemType == FILESYSTEM_NATIVE) {
// --------------------------------------------
//! Windows version
#ifdef _IRR_WINDOWS_API_
#if !defined(_WIN32_WCE)

      r = new io::file_list(Path, false, false);

      // TODO: Should be unified once mingw adapts the proper types
#if defined(_WIN64)
      intptr_t hFile;
#else
      long hFile; // mingw return type declaration
#endif

      struct _tfinddata_t c_file;
      if ((hFile = _tfindfirst((Path + _T("*")).c_str(), &c_file)) != -1L) {
        do {
          //~ fast_io::io::print(fast_io::win32_box_t(), Path + c_file.name, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
          //~ wprintf(Path + c_file.name);
          //~ wprintf(L"%ls", (Path + c_file.name).c_str());
          r->addItem(Path + c_file.name, 0, c_file.size, (_A_SUBDIR & c_file.attrib) != 0, 0);
        } while (_tfindnext(hFile, &c_file) == 0);

        _findclose(hFile);
      }
#endif

// TODO add drives
// entry.Name = "E:\\";
// entry.isDirectory = true;
// Files.push_back(entry);
#endif

// --------------------------------------------
//! Linux version
#if (defined(_IRR_POSIX_API_) || defined(_IRR_OSX_PLATFORM_))

      r = new io::CFileList(Path, false, false);

      r->addItem(Path + IRR_TEXT(".."), 0, 0, true, 0);

      //! We use the POSIX compliant methods instead of scandir
      DIR *dirHandle = opendir(Path.c_str());
      if (dirHandle) {
        struct dirent *dirEntry;
        while ((dirEntry = readdir(dirHandle))) {
          u32 size = 0;
          bool isDirectory = false;

          if ((strcmp(dirEntry->d_name, ".") == 0) || (strcmp(dirEntry->d_name, "..") == 0)) {
            continue;
          }
          struct stat buf;
          if (stat(dirEntry->d_name, &buf) == 0) {
            size = buf.st_size;
            isDirectory = S_ISDIR(buf.st_mode);
          }
#if !defined(_IRR_SOLARIS_PLATFORM_) && !defined(__CYGWIN__)
          // only available on some systems
          else {
            isDirectory = dirEntry->d_type == DT_DIR;
          }
#endif

          r->addItem(Path + dirEntry->d_name, 0, size, isDirectory, 0);
        }
        closedir(dirHandle);
      }
#endif
      //~ }
      //~ else {
      //~ //! create file list for the virtual filesystem
      //~ r = new CFileList(Path, false, false);

      //~ //! add relative navigation
      //~ SFileListEntry e2;
      //~ SFileListEntry e3;

      //~ //! PWD
      //~ r->addItem(Path + IRR_TEXT("."), 0, 0, true, 0);

      //~ //! parent
      //~ r->addItem(Path + IRR_TEXT(".."), 0, 0, true, 0);

      //~ //! merge archives
      //~ for (u32 i = 0; i < FileArchives.size(); ++i) {
      //~ const IFileList* merge = FileArchives[i]->getFileList();

      //~ for (u32 j = 0; j < merge->getFileCount(); ++j) {
      //~ if (core::isInSameDirectory(Path, merge->getFullFileName(j)) == 0) {
      //~ r->addItem(merge->getFullFileName(j), merge->getFileOffset(j), merge->getFileSize(j), merge->isDirectory(j), 0);
      //~ }
      //~ }
      //~ }
      //~ }

      if (r) {
        r->reverse_sort();
      }
      return r;
    }

    void CGUIFileSelectPanel::setItemHeight(s32 height) {
      fileListBox->setItemHeight(height);
    }

  } // namespace gui
} // namespace irr

//~ #endif
