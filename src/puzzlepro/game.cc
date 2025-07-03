
namespace ygo {

  Game *mainGame;

  void DuelInfo::Clear() {
    isStarted = false;
    isInDuel = false;
    isFinished = false;
    isReplay = false;
    isReplaySkiping = false;
    isFirst = false;
    isTag = false;
    isSingleMode = false;
    is_shuffling = false;
    tag_player[0] = false;
    tag_player[1] = false;
    isReplaySwapped = false;
    lp[0] = 0;
    lp[1] = 0;
    start_lp = 0;
    duel_rule = 0;
    turn = 0;
    curMsg = 0;
    hostname[0] = 0;
    clientname[0] = 0;
    hostname_tag[0] = 0;
    clientname_tag[0] = 0;
    strLP[0][0] = 0;
    strLP[1][0] = 0;
    player_type = 0;
    time_player = 0;
    time_limit = 0;
    time_left[0] = 0;
    time_left[1] = 0;
  }

  static int my_lua_panic(lua_State *L) {
    const char *error = lua_tostring(L, -1);
    fast_io::io::perrln("PuzzlePro Error running script: ", fast_io::mnp::os_c_str(error));
    auto debug = luabridge::getGlobal(luabridge::main_thread(L), "debug");
    fast_io::io::perrln(fast_io::mnp::os_c_str(debug["traceback"]()[0].tostring()));
#if not defined(NDEBUG)
    print_thread_stacktrace("%n %m %f %s %l");
#endif
    fast_io::fast_terminate();
  }

  lua_State *Game::create_lua_state(const char *o1) {
    lua_State *k1 = luaL_newstate();
    luaL_openlibs(k1);
    if (luaL_dofile(k1, o1)) {
      my_lua_panic(k1);
    }
    lua_atpanic(k1, my_lua_panic);
    return k1;
  }

  lua_State *Game::get_lua(boost::thread::id thread_id) {
    using boost::lock_guard;
    using boost::mutex;
    using id = boost::thread::id;

    lock_guard<mutex> mutex_guard(this->lua_mutex);

    if (this->new_lua_sup1[thread_id]) {
      return this->new_lua_sup1[thread_id];
    }

    for (auto &pair : this->new_lua_sup1) {
      if (pair.first == this->dead_thread_id) {
        pair.first = thread_id;
        return pair.second;
      }
    }

    this->new_lua_sup1[thread_id] = this->create_lua_state("./lua/main.lua");
    return this->new_lua_sup1[thread_id];
  }

  void Game::replace_new_lua_sup1() {
    using boost::lock_guard;
    using boost::mutex;

    lock_guard<mutex> mutex_guard(this->lua_mutex);

    for (auto &pair : this->new_lua_sup1) {
      this->old_lua_sup1.push_back(pair.second);
      pair.second = this->create_lua_state("./lua/main.lua");
    }

    int64_t size = 128;
    if (this->old_lua_sup1.size() > size) {
      size = this->old_lua_sup1.size() - size;
      for (int64_t i = 0; i < size; ++i) {
        lua_close(this->old_lua_sup1.front());
        this->old_lua_sup1.pop_front();
      }
    }
  }

  bool Game::Initialize() {
    using fast_io::concat_fast_io;
    LoadConfig();

    //~ create_lua();
    //~ update_lua();

    auto gui_config = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "config");
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "xy");

    irr::SIrrlichtCreationParameters params{};
    params.AntiAlias = gameConf.antialias;
    if (gameConf.use_d3d) {
      params.DriverType = irr::video::EDT_DIRECT3D9;
    }
    else {
      params.DriverType = irr::video::EDT_OPENGL;
    }
    params.WindowSize = irr::core::dimension2d<irr::u32>(gameConf.window_width, gameConf.window_height);
    device = irr::createDeviceEx(params);
    if (!device) {
      ErrorLog("Failed to create Irrlicht Engine device!");
      return false;
    }
#ifndef _DEBUG
    device->getLogger()->setLogLevel(irr::ELOG_LEVEL::ELL_ERROR);
#endif
    menuHandler.prev_operation = 0;
    menuHandler.prev_sel = -1;
    deckManager.LoadLFList();
    driver = device->getVideoDriver();
    driver->setTextureCreationFlag(irr::video::ETCF_CREATE_MIP_MAPS, false);
    driver->setTextureCreationFlag(irr::video::ETCF_OPTIMIZED_FOR_QUALITY, true);
    driver->setTextureCreationFlag(irr::video::ETCF_ALWAYS_32_BIT, true); // 避免色带
    imageManager.SetDevice(device);
    if (!imageManager.Initial()) {
      ErrorLog("Failed to load textures!");
      return false;
    }
    DataManager::FileSystem = device->getFileSystem();
    if (!dataManager.LoadDB(L"cards.cdb")) {
      ErrorLog("Failed to load card database (cards.cdb)!");
      return false;
    }
    if (!dataManager.LoadStrings("PuzzlePro_strings.conf")) {
      ErrorLog("Failed to load strings!");
      return false;
    }
    LoadExpansions();

    guiEnv = device->getGUIEnvironment();

    textFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    guiFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    guiFont->setFontHinting(true, false);
    textFont->setFontHinting(true, false);
    guiEnv->getSkin()->setFont(guiFont);

    //~ if (!numFont) {
    //~ const wchar_t *numFontPaths[] = {L"C:/Windows/Fonts/arialbd.ttf", L"/usr/share/fonts/truetype/DroidSansFallbackFull.ttf", L"/usr/share/fonts/opentype/noto/NotoSansCJK-Bold.ttc", L"/usr/share/fonts/google-noto-cjk/NotoSansCJK-Bold.ttc", L"/usr/share/fonts/noto-cjk/NotoSansCJK-Bold.ttc", L"/System/Library/Fonts/SFNSTextCondensed-Bold.otf", L"/System/Library/Fonts/SFNS.ttf", L"./fonts/numFont.ttf", L"./fonts/numFont.ttc", L"./fonts/numFont.otf"};
    //~ for (const wchar_t *path : numFontPaths) {
    //~ BufferIO::CopyWideString(path, gameConf.numfont);
    //~ numFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 16, true, true, font_outline);
    //~ if (numFont) {
    //~ break;
    //~ }
    //~ }
    //~ }
    //~ textFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    //~ if (!textFont) {
    //~ const wchar_t *textFontPaths[] = {L"C:/Windows/Fonts/msyh.ttc", L"C:/Windows/Fonts/msyh.ttf", L"C:/Windows/Fonts/simsun.ttc", L"C:/Windows/Fonts/YuGothM.ttc", L"C:/Windows/Fonts/meiryo.ttc", L"C:/Windows/Fonts/msgothic.ttc", L"/usr/share/fonts/truetype/DroidSansFallbackFull.ttf", L"/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc", L"/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc", L"/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc", L"/System/Library/Fonts/PingFang.ttc", L"./fonts/textFont.ttf", L"./fonts/textFont.ttc", L"./fonts/textFont.otf"};
    //~ for (const wchar_t *path : textFontPaths) {
    //~ BufferIO::CopyWideString(path, gameConf.textfont);
    //~ textFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    //~ if (textFont) {
    //~ break;
    //~ }
    //~ }
    //~ }
    //~ if (!numFont || !textFont) {
    //~ wchar_t fpath[1024]{};
    //~ fpath[0] = 0;
    //~ FileSystem::TraversalDir(L"./fonts", [&fpath](const wchar_t *name, bool isdir) {
    //~ if (!isdir && (IsExtension(name, L".ttf") || IsExtension(name, L".ttc") || IsExtension(name, L".otf"))) {
    //~ myswprintf(fpath, L"./fonts/%ls", name);
    //~ }
    //~ });
    //~ if (fpath[0] == 0) {
    //~ ErrorLog("No fonts found! Please place appropriate font file in the fonts directory, or edit system.conf manually.");
    //~ return false;
    //~ }
    //~ if (!numFont) {
    //~ BufferIO::CopyWideString(fpath, gameConf.numfont);
    //~ numFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 16, true, true, font_outline);
    //~ }
    //~ if (!textFont) {
    //~ BufferIO::CopyWideString(fpath, gameConf.textfont);
    //~ textFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    //~ }
    //~ }
    //~ if (!numFont || !textFont) {
    //~ ErrorLog("Failed to load font(s)!");
    //~ return false;
    //~ }
    numFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 16, true, true, font_outline);
    adFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 12, true, true, font_outline);
    lpcFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 48, true, true, font_outline);
    //~ guiFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    smgr = device->getSceneManager();
    device->setWindowCaption(L"PuzzlePro");
    device->setResizable(true);
    if (gameConf.window_maximized) {
      device->maximizeWindow();
    }
    //~ #ifdef _WIN32
    irr::video::SExposedVideoData exposedData = driver->getExposedVideoData();
    //~ if (gameConf.use_d3d) {
    //~ hWnd = reinterpret_cast<HWND>(exposedData.D3D9.HWnd);
    //~ }
    //~ else {
    hWnd = reinterpret_cast<HWND>(exposedData.OpenGLWin32.HWnd);
    //~ }
    //~ #endif
    SetWindowsIcon();

    static_text_deck_edit_main_deck_size = guiEnv->addStaticText(L"", irr::core::rect<int32_t>(0, 0, 0, 0), true, true, nullptr, -1, true);
    static_text_deck_edit_main_deck_size->setVisible(false);
    static_text_deck_edit_main_deck_size->setTextAlignment(static_cast<irr::gui::EGUI_ALIGNMENT>(0), irr::gui::EGUIA_CENTER);
    static_text_deck_edit_extra_deck_size = guiEnv->addStaticText(L"", irr::core::rect<int32_t>(0, 0, 0, 0), true, true, nullptr, -1, true);
    static_text_deck_edit_extra_deck_size->setVisible(false);
    static_text_deck_edit_extra_deck_size->setTextAlignment(static_cast<irr::gui::EGUI_ALIGNMENT>(0), irr::gui::EGUIA_CENTER);
    static_text_deck_edit_side_deck_size = guiEnv->addStaticText(L"", irr::core::rect<int32_t>(0, 0, 0, 0), true, true, nullptr, -1, true);
    static_text_deck_edit_side_deck_size->setVisible(false);
    static_text_deck_edit_side_deck_size->setTextAlignment(static_cast<irr::gui::EGUI_ALIGNMENT>(0), irr::gui::EGUIA_CENTER);
    static_text_deck_edit_search_result_size = guiEnv->addStaticText(L"", irr::core::rect<int32_t>(0, 0, 0, 0), true, true, nullptr, -1, true);
    static_text_deck_edit_search_result_size->setVisible(false);
    static_text_deck_edit_search_result_size->setTextAlignment(static_cast<irr::gui::EGUI_ALIGNMENT>(0), irr::gui::EGUIA_CENTER);

    // main menu
    wchar_t strbuf[256];
    myswprintf(strbuf, L"PuzzlePro Version:%X.0%X.%X", (PRO_VERSION & 0xf000U) >> 12, (PRO_VERSION & 0x0ff0U) >> 4, PRO_VERSION & 0x000fU);
    wMainMenu = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wMainMenu"]["x1"], gui_xy["wMainMenu"]["y1"], gui_xy["wMainMenu"]["x2"], gui_xy["wMainMenu"]["y2"]), false, strbuf);
    wMainMenu->getCloseButton()->setVisible(false);
    btnLanMode = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnLanMode"]["x1"], gui_xy["btnLanMode"]["y1"], gui_xy["btnLanMode"]["x2"], gui_xy["btnLanMode"]["y2"]), wMainMenu, BUTTON_LAN_MODE, dataManager.GetSysString(1200));
    btnSingleMode = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnSingleMode"]["x1"], gui_xy["btnSingleMode"]["y1"], gui_xy["btnSingleMode"]["x2"], gui_xy["btnSingleMode"]["y2"]), wMainMenu, BUTTON_SINGLE_MODE, dataManager.GetSysString(1201));
    btnReplayMode = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnReplayMode"]["x1"], gui_xy["btnReplayMode"]["y1"], gui_xy["btnReplayMode"]["x2"], gui_xy["btnReplayMode"]["y2"]), wMainMenu, BUTTON_REPLAY_MODE, dataManager.GetSysString(1202));
    //	btnTestMode = guiEnv->addButton(irr::core::rect<irr::s32>(10, 135, 270, 165), wMainMenu,
    // BUTTON_TEST_MODE, dataManager.GetSysString(1203));
    btnDeckEdit = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnDeckEdit"]["x1"], gui_xy["btnDeckEdit"]["y1"], gui_xy["btnDeckEdit"]["x2"], gui_xy["btnDeckEdit"]["y2"]), wMainMenu, BUTTON_DECK_EDIT, dataManager.GetSysString(1204));
    btnModeExit = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnModeExit"]["x1"], gui_xy["btnModeExit"]["y1"], gui_xy["btnModeExit"]["x2"], gui_xy["btnModeExit"]["y2"]), wMainMenu, BUTTON_MODE_EXIT, dataManager.GetSysString(1210));

    // lan mode
    wLanWindow = guiEnv->addWindow(irr::core::rect<irr::s32>(220, 100, 800, 520), false, dataManager.GetSysString(1200));
    wLanWindow->getCloseButton()->setVisible(false);
    wLanWindow->setVisible(false);
    guiEnv->addStaticText(dataManager.GetSysString(1220), irr::core::rect<irr::s32>(10, 30, 220, 50), false, false, wLanWindow);
    ebNickName = guiEnv->addEditBox(gameConf.nickname, irr::core::rect<irr::s32>(110, 25, 450, 50), true, wLanWindow);
    ebNickName->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    lstHostList = guiEnv->addListBox(irr::core::rect<irr::s32>(10, 60, 570, 320), wLanWindow, LISTBOX_LAN_HOST, true);
    lstHostList->setItemHeight(18);
    btnLanRefresh = guiEnv->addButton(irr::core::rect<irr::s32>(240, 325, 340, 350), wLanWindow, BUTTON_LAN_REFRESH, dataManager.GetSysString(1217));
    guiEnv->addStaticText(dataManager.GetSysString(1221), irr::core::rect<irr::s32>(10, 360, 220, 380), false, false, wLanWindow);
    ebJoinHost = guiEnv->addEditBox(gameConf.lasthost, irr::core::rect<irr::s32>(110, 355, 350, 380), true, wLanWindow);
    ebJoinHost->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    ebJoinPort = guiEnv->addEditBox(gameConf.lastport, irr::core::rect<irr::s32>(360, 355, 420, 380), true, wLanWindow);
    ebJoinPort->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1222), irr::core::rect<irr::s32>(10, 390, 220, 410), false, false, wLanWindow);
    ebJoinPass = guiEnv->addEditBox(gameConf.roompass, irr::core::rect<irr::s32>(110, 385, 420, 410), true, wLanWindow);
    ebJoinPass->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    btnJoinHost = guiEnv->addButton(irr::core::rect<irr::s32>(460, 355, 570, 380), wLanWindow, BUTTON_JOIN_HOST, dataManager.GetSysString(1223));
    btnJoinCancel = guiEnv->addButton(irr::core::rect<irr::s32>(460, 385, 570, 410), wLanWindow, BUTTON_JOIN_CANCEL, dataManager.GetSysString(1212));
    btnCreateHost = guiEnv->addButton(irr::core::rect<irr::s32>(460, 25, 570, 50), wLanWindow, BUTTON_CREATE_HOST, dataManager.GetSysString(1224));
    // create host
    wCreateHost = guiEnv->addWindow(irr::core::rect<irr::s32>(320, 100, 700, 520), false, dataManager.GetSysString(1224));
    wCreateHost->getCloseButton()->setVisible(false);
    wCreateHost->setVisible(false);
    guiEnv->addStaticText(dataManager.GetSysString(1226), irr::core::rect<irr::s32>(20, 30, 220, 50), false, false, wCreateHost);
    cbHostLFlist = guiEnv->addComboBox(irr::core::rect<irr::s32>(140, 25, 300, 50), wCreateHost);
    for (unsigned int i = 0; i < deckManager._lfList.size(); ++i) {
      cbHostLFlist->addItem(deckManager._lfList[i].listName.c_str(), deckManager._lfList[i].hash);
    }
    cbHostLFlist->setSelected(gameConf.use_lflist ? gameConf.default_lflist : cbHostLFlist->getItemCount() - 1);
    guiEnv->addStaticText(dataManager.GetSysString(1225), irr::core::rect<irr::s32>(20, 60, 220, 80), false, false, wCreateHost);
    cbRule = guiEnv->addComboBox(irr::core::rect<irr::s32>(140, 55, 300, 80), wCreateHost);
    cbRule->setMaxSelectionRows(10);
    cbRule->addItem(dataManager.GetSysString(1481));
    cbRule->addItem(dataManager.GetSysString(1482));
    cbRule->addItem(dataManager.GetSysString(1483));
    cbRule->addItem(dataManager.GetSysString(1484));
    cbRule->addItem(dataManager.GetSysString(1485));
    cbRule->addItem(dataManager.GetSysString(1486));
    switch (gameConf.defaultOT) {
      case 1:
        cbRule->setSelected(0);
        break;
      case 2:
        cbRule->setSelected(1);
        break;
      case 4:
        cbRule->setSelected(3);
        break;
      case 8:
        cbRule->setSelected(2);
        break;
      default:
        cbRule->setSelected(5);
        break;
    }
    guiEnv->addStaticText(dataManager.GetSysString(1227), irr::core::rect<irr::s32>(20, 90, 220, 110), false, false, wCreateHost);
    cbMatchMode = guiEnv->addComboBox(irr::core::rect<irr::s32>(140, 85, 300, 110), wCreateHost);
    cbMatchMode->addItem(dataManager.GetSysString(1244));
    cbMatchMode->addItem(dataManager.GetSysString(1245));
    cbMatchMode->addItem(dataManager.GetSysString(1246));
    guiEnv->addStaticText(dataManager.GetSysString(1237), irr::core::rect<irr::s32>(20, 120, 320, 140), false, false, wCreateHost);
    myswprintf(strbuf, L"%d", 180);
    ebTimeLimit = guiEnv->addEditBox(strbuf, irr::core::rect<irr::s32>(140, 115, 220, 140), true, wCreateHost);
    ebTimeLimit->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1228), irr::core::rect<irr::s32>(20, 150, 320, 170), false, false, wCreateHost);
    guiEnv->addStaticText(dataManager.GetSysString(1236), irr::core::rect<irr::s32>(20, 180, 220, 200), false, false, wCreateHost);
    cbDuelRule = guiEnv->addComboBox(irr::core::rect<irr::s32>(140, 175, 300, 200), wCreateHost);
    cbDuelRule->addItem(dataManager.GetSysString(1260));
    cbDuelRule->addItem(dataManager.GetSysString(1261));
    cbDuelRule->addItem(dataManager.GetSysString(1262));
    cbDuelRule->addItem(dataManager.GetSysString(1263));
    cbDuelRule->addItem(dataManager.GetSysString(1264));
    cbDuelRule->setSelected(gameConf.default_rule - 1);
    chkNoCheckDeck = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(20, 210, 170, 230), wCreateHost, -1, dataManager.GetSysString(1229));
    chkNoShuffleDeck = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(180, 210, 360, 230), wCreateHost, -1, dataManager.GetSysString(1230));
    guiEnv->addStaticText(dataManager.GetSysString(1231), irr::core::rect<irr::s32>(20, 240, 320, 260), false, false, wCreateHost);
    myswprintf(strbuf, L"%d", 8000);
    ebStartLP = guiEnv->addEditBox(strbuf, irr::core::rect<irr::s32>(140, 235, 220, 260), true, wCreateHost);
    ebStartLP->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1232), irr::core::rect<irr::s32>(20, 270, 320, 290), false, false, wCreateHost);
    myswprintf(strbuf, L"%d", 5);
    ebStartHand = guiEnv->addEditBox(strbuf, irr::core::rect<irr::s32>(140, 265, 220, 290), true, wCreateHost);
    ebStartHand->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1233), irr::core::rect<irr::s32>(20, 300, 320, 320), false, false, wCreateHost);
    myswprintf(strbuf, L"%d", 1);
    ebDrawCount = guiEnv->addEditBox(strbuf, irr::core::rect<irr::s32>(140, 295, 220, 320), true, wCreateHost);
    ebDrawCount->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1234), irr::core::rect<irr::s32>(10, 360, 220, 380), false, false, wCreateHost);
    ebServerName = guiEnv->addEditBox(gameConf.gamename, irr::core::rect<irr::s32>(110, 355, 250, 380), true, wCreateHost);
    ebServerName->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    guiEnv->addStaticText(dataManager.GetSysString(1235), irr::core::rect<irr::s32>(10, 390, 220, 410), false, false, wCreateHost);
    ebServerPass = guiEnv->addEditBox(L"", irr::core::rect<irr::s32>(110, 385, 250, 410), true, wCreateHost);
    ebServerPass->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    btnHostConfirm = guiEnv->addButton(irr::core::rect<irr::s32>(260, 355, 370, 380), wCreateHost, BUTTON_HOST_CONFIRM, dataManager.GetSysString(1211));
    btnHostCancel = guiEnv->addButton(irr::core::rect<irr::s32>(260, 385, 370, 410), wCreateHost, BUTTON_HOST_CANCEL, dataManager.GetSysString(1212));
    // host(single)
    wHostPrepare = guiEnv->addWindow(irr::core::rect<irr::s32>(270, 120, 750, 440), false, dataManager.GetSysString(1250));
    wHostPrepare->getCloseButton()->setVisible(false);
    wHostPrepare->setVisible(false);
    btnHostPrepDuelist = guiEnv->addButton(irr::core::rect<irr::s32>(10, 30, 110, 55), wHostPrepare, BUTTON_HP_DUELIST, dataManager.GetSysString(1251));
    for (int i = 0; i < 2; ++i) {
      stHostPrepDuelist[i] = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(40, 65 + i * 25, 240, 85 + i * 25), true, false, wHostPrepare);
      btnHostPrepKick[i] = guiEnv->addButton(irr::core::rect<irr::s32>(10, 65 + i * 25, 30, 85 + i * 25), wHostPrepare, BUTTON_HP_KICK, L"X");
      chkHostPrepReady[i] = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(250, 65 + i * 25, 270, 85 + i * 25), wHostPrepare, CHECKBOX_HP_READY, L"");
      chkHostPrepReady[i]->setEnabled(false);
    }
    for (int i = 2; i < 4; ++i) {
      stHostPrepDuelist[i] = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(40, 75 + i * 25, 240, 95 + i * 25), true, false, wHostPrepare);
      btnHostPrepKick[i] = guiEnv->addButton(irr::core::rect<irr::s32>(10, 75 + i * 25, 30, 95 + i * 25), wHostPrepare, BUTTON_HP_KICK, L"X");
      chkHostPrepReady[i] = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(250, 75 + i * 25, 270, 95 + i * 25), wHostPrepare, CHECKBOX_HP_READY, L"");
      chkHostPrepReady[i]->setEnabled(false);
    }
    btnHostPrepOB = guiEnv->addButton(irr::core::rect<irr::s32>(10, 180, 110, 205), wHostPrepare, BUTTON_HP_OBSERVER, dataManager.GetSysString(1252));
    myswprintf(strbuf, L"%ls%d", dataManager.GetSysString(1253), 0);
    stHostPrepOB = guiEnv->addStaticText(strbuf, irr::core::rect<irr::s32>(10, 285, 270, 305), false, false, wHostPrepare);
    stHostPrepRule = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(280, 30, 460, 230), false, true, wHostPrepare);
    guiEnv->addStaticText(dataManager.GetSysString(1254), irr::core::rect<irr::s32>(10, 210, 110, 230), false, false, wHostPrepare);
    cbCategorySelect = guiEnv->addComboBox(irr::core::rect<irr::s32>(10, 230, 138, 255), wHostPrepare, COMBOBOX_HP_CATEGORY);
    cbCategorySelect->setMaxSelectionRows(10);
    cbDeckSelect = guiEnv->addComboBox(irr::core::rect<irr::s32>(142, 230, 340, 255), wHostPrepare);
    cbDeckSelect->setMaxSelectionRows(10);
    btnHostPrepReady = guiEnv->addButton(irr::core::rect<irr::s32>(170, 180, 270, 205), wHostPrepare, BUTTON_HP_READY, dataManager.GetSysString(1218));
    btnHostPrepNotReady = guiEnv->addButton(irr::core::rect<irr::s32>(170, 180, 270, 205), wHostPrepare, BUTTON_HP_NOTREADY, dataManager.GetSysString(1219));
    btnHostPrepNotReady->setVisible(false);
    btnHostPrepStart = guiEnv->addButton(irr::core::rect<irr::s32>(230, 280, 340, 305), wHostPrepare, BUTTON_HP_START, dataManager.GetSysString(1215));
    btnHostPrepCancel = guiEnv->addButton(irr::core::rect<irr::s32>(350, 280, 460, 305), wHostPrepare, BUTTON_HP_CANCEL, dataManager.GetSysString(1210));
    // img
    wCardImg = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("wCardImg"), true, false, nullptr, -1, true);
    //~ wCardImg->setBackgroundColor(0xc0c0c0c0);
    wCardImg->setVisible(false);
    imgCard = guiEnv->addImage(get_origin_rect<int32_t>("imgCard"), wCardImg);
    imgCard->setImage(imageManager.tCover[0]);
    showingcode = 0;
    //~ imgCard->setRelativePositionProportional(get_origin_rect_impl<float>("imgCard"));
    //~ imgCard->setRelativePositionProportional(irr::core::rect<float>(0,0,1,1));
    //~ 避免背面卡图的宽高不对
    //~ imgCard->setScaleImage(true);

    //~ imgCard->setUseAlphaChannel(true);

    //~ should_resize_element_unordered_map_int.insert_or_assign(wCardImg, "wCardImg");
    //~ should_resize_element_unordered_map_int.insert_or_assign(imgCard, "imgCard");

    // phase
    wPhase = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("wPhase"));
    wPhase->setVisible(false);
    btnPhaseStatus = guiEnv->addButton(irr::core::rect<irr::s32>(0, 0, 50, 20), wPhase, BUTTON_PHASE, L"");
    btnPhaseStatus->setIsPushButton(true);
    btnPhaseStatus->setPressed(true);
    btnPhaseStatus->setVisible(false);
    btnBP = guiEnv->addButton(get_origin_rect<int32_t>("btnBP"), wPhase, BUTTON_BP, L"\xff22\xff30");
    btnBP->setVisible(false);
    btnM2 = guiEnv->addButton(get_origin_rect<int32_t>("btnM2"), wPhase, BUTTON_M2, L"\xff2d\xff12");
    btnM2->setVisible(false);
    btnEP = guiEnv->addButton(get_origin_rect<int32_t>("btnEP"), wPhase, BUTTON_EP, L"\xff25\xff30");
    btnEP->setVisible(false);
    // tab
    wInfos = guiEnv->addTabControl(get_origin_rect<int32_t>("wInfos"), nullptr, true);
    wInfos->setTabExtraWidth(16);
    wInfos->setVisible(false);

    //~ should_resize_element_unordered_map_int.insert_or_assign(wInfos, "wInfos");

    // info
    irr::gui::IGUITab *tabInfo = wInfos->addTab(dataManager.GetSysString(1270));
    stDataInfo = irr::gui::CGUIScrollText::addScrollText(guiEnv, L"", irr::core::rect<irr::s32>(gui_xy["stDataInfo"]["x1"], gui_xy["stDataInfo"]["y1"], gui_xy["stDataInfo"]["x2"], gui_xy["stDataInfo"]["y2"]), false, true, tabInfo, TEXT_DATA_INFO, false);
    //~ stDataInfo->setToolTipText(L"ksdfkdsfkdsfsd");
    stDataInfo->setHideScrollbar(true);
    stText = irr::gui::CGUIScrollText::addScrollText(guiEnv, L"", irr::core::rect<irr::s32>(gui_xy["stText"]["x1"], gui_xy["stText"]["y1"], gui_xy["stText"]["x2"], gui_xy["stText"]["y2"]), false, true, tabInfo, -1, false);

    //~ should_resize_element_unordered_map_int.insert_or_assign(stDataInfo, "stDataInfo");
    //~ should_resize_element_unordered_map_int.insert_or_assign(stText, "stText");

    // log
    irr::gui::IGUITab *tabLog = wInfos->addTab(dataManager.GetSysString(1271));
    lstLog = guiEnv->addListBox(get_origin_rect<int32_t>("lstLog"), tabLog, LISTBOX_LOG, false);
    //~ lstLog->setItemHeight(18);
    btnClearLog = guiEnv->addButton(get_origin_rect<int32_t>("btnClearLog"), tabLog, BUTTON_CLEAR_LOG, dataManager.GetSysString(1272));
    // helper
    irr::gui::IGUITab *_tabHelper = wInfos->addTab(dataManager.GetSysString(1298));
    _tabHelper->setRelativePosition(irr::core::recti(16, 49, 299, 362));
    tabHelper = guiEnv->addWindow(irr::core::recti(0, 0, 250, 300), false, L"", _tabHelper);
    tabHelper->setDrawTitlebar(false);
    tabHelper->getCloseButton()->setVisible(false);
    tabHelper->setDrawBackground(false);
    tabHelper->setDraggable(false);
    scrTabHelper = guiEnv->addScrollBar(false, irr::core::rect<irr::s32>(252, 0, 272, 300), _tabHelper, SCROLL_TAB_HELPER);
    scrTabHelper->setLargeStep(1);
    scrTabHelper->setSmallStep(1);
    scrTabHelper->setVisible(false);
    int posX = 0;
    int posY = 0;
    chkMAutoPos = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1274));
    chkMAutoPos->setChecked(gameConf.chkMAutoPos != 0);
    posY += 30;
    chkSTAutoPos = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1278));
    chkSTAutoPos->setChecked(gameConf.chkSTAutoPos != 0);
    posY += 30;
    chkRandomPos = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX + 20, posY, posX + 20 + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1275));
    chkRandomPos->setChecked(gameConf.chkRandomPos != 0);
    posY += 30;
    chkAutoChain = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1276));
    chkAutoChain->setChecked(gameConf.chkAutoChain != 0);
    posY += 30;
    chkWaitChain = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1277));
    chkWaitChain->setChecked(gameConf.chkWaitChain != 0);
    posY += 30;
    chkDefaultShowChain = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1354));
    chkDefaultShowChain->setChecked(gameConf.chkDefaultShowChain != 0);
    posY += 30;
    chkQuickAnimation = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, CHECKBOX_QUICK_ANIMATION, dataManager.GetSysString(1299));
    chkQuickAnimation->setChecked(gameConf.quick_animation != 0);
    posY += 30;
    chkDrawSingleChain = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, CHECKBOX_DRAW_SINGLE_CHAIN, dataManager.GetSysString(1287));
    chkDrawSingleChain->setChecked(gameConf.draw_single_chain != 0);
    posY += 30;
    //~ chkAutoSaveReplay = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabHelper, -1, dataManager.GetSysString(1366));
    //~ chkAutoSaveReplay->setChecked(gameConf.auto_save_replay != 0);
    //~ elmTabHelperLast = chkAutoSaveReplay;

    //~ auto kkk = new irr::gui::CGUIPanel(guiEnv, dynamic_cast<irr::gui::CGUIEnvironment*>(guiEnv), -1, irr::core::rect<irr::s32>(20, 300, 600, 600));
    //~ auto kkksfds = guiEnv->addWindow(irr::core::recti(0, 0, 250, 300), false, L"猪猪猪", kkk);
    //~ auto sdfds = guiEnv->addStaticText(dataManager.GetSysString(1233), irr::core::rect<irr::s32>(20, 300, 320, 320), false, false, kkk);

    // system
    irr::gui::IGUITab *_tabSystem = wInfos->addTab(dataManager.GetSysString(1273));
    //~ _tabSystem->setRelativePosition(irr::core::recti(16, 49, 299, 362));
    tabSystem = guiEnv->addWindow(irr::core::recti(0, 0, 250, 300), false, L"", _tabSystem);
    tabSystem->setDrawTitlebar(false);
    tabSystem->getCloseButton()->setVisible(false);
    tabSystem->setDrawBackground(false);
    tabSystem->setDraggable(false);
    //~ scrTabSystem = guiEnv->addScrollBar(false, irr::core::rect<irr::s32>(252, 0, 272, 300), _tabSystem, SCROLL_TAB_SYSTEM);
    //~ scrTabSystem->setLargeStep(1);
    //~ scrTabSystem->setSmallStep(1);
    //~ scrTabSystem->setVisible(false);
    //~ system_setting_tab = new irr::gui::CGUIPanel(guiEnv, dynamic_cast<irr::gui::CGUIEnvironment*>(guiEnv), -1, irr::core::rect<irr::s32>(0, 0, 250, 300));
    //~ system_setting_tab = new irr::gui::CGUIPanel(guiEnv, _tabSystem, -1, irr::core::rect<irr::s32>(0, 0, 250, 300));
    system_setting_tab = addCGUIPanel(guiEnv, _tabSystem, -1, get_origin_rect<int32_t>("system_setting_tab"), false, irr::gui::ESBM_AUTOMATIC, irr::gui::ESBM_AUTOMATIC);
    //~ system_setting_tab->addChild(tabSystem);
    posY = 0;
    //~ chkIgnore1 = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), tabSystem, CHECKBOX_DISABLE_CHAT, dataManager.GetSysString(1290));
    chkIgnore1 = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, CHECKBOX_DISABLE_CHAT, dataManager.GetSysString(1290));
    system_setting_tab->addChild(chkIgnore1);
    chkIgnore1->setChecked(gameConf.chkIgnore1 != 0);
    posY += 30;
    chkIgnore2 = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, -1, dataManager.GetSysString(1291));
    system_setting_tab->addChild(chkIgnore2);
    chkIgnore2->setChecked(gameConf.chkIgnore2 != 0);
    posY += 30;
    chkHidePlayerName = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, CHECKBOX_HIDE_PLAYER_NAME, dataManager.GetSysString(1289));
    system_setting_tab->addChild(chkHidePlayerName);
    chkHidePlayerName->setChecked(gameConf.hide_player_name != 0);
    posY += 30;
    chkIgnoreDeckChanges = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, -1, dataManager.GetSysString(1357));
    system_setting_tab->addChild(chkIgnoreDeckChanges);
    chkIgnoreDeckChanges->setChecked(gameConf.chkIgnoreDeckChanges != 0);
    posY += 30;
    chkAutoSearch = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, CHECKBOX_AUTO_SEARCH, dataManager.GetSysString(1358));
    system_setting_tab->addChild(chkAutoSearch);
    chkAutoSearch->setChecked(gameConf.auto_search_limit >= 0);
    posY += 30;
    chkMultiKeywords = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, CHECKBOX_MULTI_KEYWORDS, dataManager.GetSysString(1378));
    system_setting_tab->addChild(chkMultiKeywords);
    chkMultiKeywords->setChecked(gameConf.search_multiple_keywords > 0);
    posY += 30;
    chkPreferExpansionScript = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, CHECKBOX_PREFER_EXPANSION, dataManager.GetSysString(1379));
    system_setting_tab->addChild(chkPreferExpansionScript);
    chkPreferExpansionScript->setChecked(gameConf.prefer_expansion_script != 0);
    posY += 30;
    static_text_window_size = guiEnv->addStaticText(dataManager.GetSysString(1282), irr::core::rect<irr::s32>(posX + 23, posY + 3, posX + 110, posY + 28), false, false, system_setting_tab);
    system_setting_tab->addChild(static_text_window_size);
    btnWinResizeS = guiEnv->addButton(irr::core::rect<irr::s32>(posX + 115, posY, posX + 145, posY + 25), system_setting_tab, BUTTON_WINDOW_RESIZE_S, dataManager.GetSysString(1283));
    system_setting_tab->addChild(btnWinResizeS);
    btnWinResizeM = guiEnv->addButton(irr::core::rect<irr::s32>(posX + 150, posY, posX + 180, posY + 25), system_setting_tab, BUTTON_WINDOW_RESIZE_M, dataManager.GetSysString(1284));
    system_setting_tab->addChild(btnWinResizeM);
    btnWinResizeL = guiEnv->addButton(irr::core::rect<irr::s32>(posX + 185, posY, posX + 215, posY + 25), system_setting_tab, BUTTON_WINDOW_RESIZE_L, dataManager.GetSysString(1285));
    system_setting_tab->addChild(btnWinResizeL);
    btnWinResizeXL = guiEnv->addButton(irr::core::rect<irr::s32>(posX + 220, posY, posX + 250, posY + 25), system_setting_tab, BUTTON_WINDOW_RESIZE_XL, dataManager.GetSysString(1286));
    system_setting_tab->addChild(btnWinResizeXL);
    posY += 30;
    chkLFlist = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 110, posY + 25), system_setting_tab, CHECKBOX_LFLIST, dataManager.GetSysString(1288));
    system_setting_tab->addChild(chkLFlist);
    chkLFlist->setChecked(gameConf.use_lflist);
    cbLFlist = guiEnv->addComboBox(irr::core::rect<irr::s32>(posX + 115, posY, posX + 250, posY + 25), system_setting_tab, COMBOBOX_LFLIST);
    system_setting_tab->addChild(cbLFlist);
    cbLFlist->setMaxSelectionRows(6);
    for (unsigned int i = 0; i < deckManager._lfList.size(); ++i) {
      cbLFlist->addItem(deckManager._lfList[i].listName.c_str());
    }
    cbLFlist->setEnabled(gameConf.use_lflist);
    cbLFlist->setSelected(gameConf.use_lflist ? gameConf.default_lflist : cbLFlist->getItemCount() - 1);
    posY += 30;
    chkEnableSound = guiEnv->addCheckBox(gameConf.enable_sound, irr::core::rect<irr::s32>(posX, posY, posX + 120, posY + 25), system_setting_tab, -1, dataManager.GetSysString(1279));
    system_setting_tab->addChild(chkEnableSound);
    chkEnableSound->setChecked(gameConf.enable_sound);
    scrSoundVolume = guiEnv->addScrollBar(true, irr::core::rect<irr::s32>(posX + 116, posY + 4, posX + 250, posY + 21), system_setting_tab, SCROLL_VOLUME);
    system_setting_tab->addChild(scrSoundVolume);
    scrSoundVolume->setMax(100);
    scrSoundVolume->setMin(0);
    scrSoundVolume->setPos(gameConf.sound_volume * 100);
    scrSoundVolume->setLargeStep(1);
    scrSoundVolume->setSmallStep(1);
    posY += 30;
    chkEnableMusic = guiEnv->addCheckBox(gameConf.enable_music, irr::core::rect<irr::s32>(posX, posY, posX + 120, posY + 25), system_setting_tab, CHECKBOX_ENABLE_MUSIC, dataManager.GetSysString(1280));
    system_setting_tab->addChild(chkEnableMusic);
    chkEnableMusic->setChecked(gameConf.enable_music);
    scrMusicVolume = guiEnv->addScrollBar(true, irr::core::rect<irr::s32>(posX + 116, posY + 4, posX + 250, posY + 21), system_setting_tab, SCROLL_VOLUME);
    system_setting_tab->addChild(scrMusicVolume);
    scrMusicVolume->setMax(100);
    scrMusicVolume->setMin(0);
    scrMusicVolume->setPos(gameConf.music_volume * 100);
    scrMusicVolume->setLargeStep(1);
    scrMusicVolume->setSmallStep(1);
    posY += 30;
    chkMusicMode = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(posX, posY, posX + 260, posY + 25), system_setting_tab, -1, dataManager.GetSysString(1281));
    system_setting_tab->addChild(chkMusicMode);
    chkMusicMode->setChecked(gameConf.music_mode != 0);
    elmTabSystemLast = chkMusicMode;

    //~ tabSystem = new irr::gui::CGUIPanel(guiEnv, dynamic_cast<irr::gui::CGUIEnvironment*>(guiEnv), -1, irr::core::rect<irr::s32>(0, 0, 250, 300));

    //
    wHand = guiEnv->addWindow(irr::core::rect<irr::s32>(500, 450, 825, 605), false, L"");
    wHand->getCloseButton()->setVisible(false);
    wHand->setDraggable(false);
    wHand->setDrawTitlebar(false);
    wHand->setVisible(false);
    for (int i = 0; i < 3; ++i) {
      btnHand[i] = guiEnv->addButton(irr::core::rect<irr::s32>(10 + 105 * i, 10, 105 + 105 * i, 144), wHand, BUTTON_HAND1 + i, L"");
      btnHand[i]->setImage(imageManager.tHand[i]);
    }
    //
    wFTSelect = guiEnv->addWindow(irr::core::rect<irr::s32>(550, 240, 780, 340), false, L"");
    wFTSelect->getCloseButton()->setVisible(false);
    wFTSelect->setVisible(false);
    btnFirst = guiEnv->addButton(irr::core::rect<irr::s32>(10, 30, 220, 55), wFTSelect, BUTTON_FIRST, dataManager.GetSysString(100));
    btnSecond = guiEnv->addButton(irr::core::rect<irr::s32>(10, 60, 220, 85), wFTSelect, BUTTON_SECOND, dataManager.GetSysString(101));
    //~ irr::gui::IGUIWindow* sdfdsf = irr::gui::CGUIScrollMessage::addScrollMessage(guiEnv, L"消息", L"你是猪", true, EMBF_OK);
    // message (310)
    wMessage = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wMessage"]["x1"], gui_xy["wMessage"]["y1"], gui_xy["wMessage"]["x2"], gui_xy["wMessage"]["y2"]), false, dataManager.GetSysString(1216));
    smMessage = irr::gui::CGUIScrollMessage::addScrollMessage(guiEnv, irr::core::rect<irr::s32>(gui_xy["smMessage"]["x1"], gui_xy["smMessage"]["y1"], gui_xy["smMessage"]["x2"], gui_xy["smMessage"]["y2"]));
    smMessage->setVisible(false);
    wMessage->getCloseButton()->setVisible(false);
    wMessage->setVisible(false);
    stMessage = irr::gui::CGUIScrollText::addScrollText(guiEnv, L"", irr::core::rect<irr::s32>(gui_xy["stMessage"]["x1"], gui_xy["stMessage"]["y1"], gui_xy["stMessage"]["x2"], gui_xy["stMessage"]["y2"]), false, true, wMessage, -1, false);
    btnMsgOK = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnMsgOK"]["x1"], gui_xy["btnMsgOK"]["y1"], gui_xy["btnMsgOK"]["x2"], gui_xy["btnMsgOK"]["y2"]), wMessage, BUTTON_MSG_OK, dataManager.GetSysString(1211));
    // auto fade message (310)
    wACMessage = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wACMessage"]["x1"], gui_xy["wACMessage"]["y1"], gui_xy["wACMessage"]["x2"], gui_xy["wACMessage"]["y2"]), false, L"");
    wACMessage->getCloseButton()->setVisible(false);
    wACMessage->setVisible(false);
    wACMessage->setDrawBackground(false);
    stACMessage = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(gui_xy["stACMessage"]["x1"], gui_xy["stACMessage"]["y1"], gui_xy["stACMessage"]["x2"], gui_xy["stACMessage"]["y2"]), true, true, wACMessage, -1, true);
    stACMessage->setBackgroundColor(0xc0c0c0ff);
    stACMessage->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    // yes/no (310)
    wQuery = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wQuery"]["x1"], gui_xy["wQuery"]["y1"], gui_xy["wQuery"]["x2"], gui_xy["wQuery"]["y2"]), false, dataManager.GetSysString(560));
    wQuery->getCloseButton()->setVisible(false);
    wQuery->setVisible(false);
    stQMessage = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(gui_xy["stQMessage"]["x1"], gui_xy["stQMessage"]["y1"], gui_xy["stQMessage"]["x2"], gui_xy["stQMessage"]["y2"]), false, true, wQuery, -1, false);
    stQMessage->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    btnYes = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnYes"]["x1"], gui_xy["btnYes"]["y1"], gui_xy["btnYes"]["x2"], gui_xy["btnYes"]["y2"]), wQuery, BUTTON_YES, dataManager.GetSysString(1213));
    btnNo = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnNo"]["x1"], gui_xy["btnNo"]["y1"], gui_xy["btnNo"]["x2"], gui_xy["btnNo"]["y2"]), wQuery, BUTTON_NO, dataManager.GetSysString(1214));
    // surrender yes/no (310)
    wSurrender = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wSurrender"]["x1"], gui_xy["wSurrender"]["y1"], gui_xy["wSurrender"]["x2"], gui_xy["wSurrender"]["y2"]), false, dataManager.GetSysString(560));
    wSurrender->getCloseButton()->setVisible(false);
    wSurrender->setVisible(false);
    stSurrenderMessage = guiEnv->addStaticText(dataManager.GetSysString(1359), irr::core::rect<irr::s32>(gui_xy["stSurrenderMessage"]["x1"], gui_xy["stSurrenderMessage"]["y1"], gui_xy["stSurrenderMessage"]["x2"], gui_xy["stSurrenderMessage"]["y2"]), false, true, wSurrender, -1, false);
    stSurrenderMessage->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    btnSurrenderYes = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnSurrenderYes"]["x1"], gui_xy["btnSurrenderYes"]["y1"], gui_xy["btnSurrenderYes"]["x2"], gui_xy["btnSurrenderYes"]["y2"]), wSurrender, BUTTON_SURRENDER_YES, dataManager.GetSysString(1213));
    btnSurrenderNo = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnSurrenderNo"]["x1"], gui_xy["btnSurrenderNo"]["y1"], gui_xy["btnSurrenderNo"]["x2"], gui_xy["btnSurrenderNo"]["y2"]), wSurrender, BUTTON_SURRENDER_NO, dataManager.GetSysString(1214));
    // options (310)
    wOptions = guiEnv->addWindow(get_origin_rect<int32_t>("wOptions"), false, L"");
    wOptions->getCloseButton()->setVisible(false);
    wOptions->setVisible(false);
    btnOptionOK = guiEnv->addButton(get_origin_rect<int32_t>("btnOptionOK"), wOptions, BUTTON_OPTION_OK, dataManager.GetSysString(1211));
    wOptions_combo_box_option = guiEnv->addComboBox(get_origin_rect<int32_t>("wOptions_combo_box_option"), wOptions, wOptions_combo_box_option_id);
    // pos select
    wPosSelect = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wPosSelect"]["x1"], gui_xy["wPosSelect"]["y1"], gui_xy["wPosSelect"]["x2"], gui_xy["wPosSelect"]["y2"]), false, dataManager.GetSysString(561));
    wPosSelect->getCloseButton()->setVisible(false);
    wPosSelect->setVisible(false);
    btnPSAU = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(gui_xy["btnPSAU"]["x1"], gui_xy["btnPSAU"]["y1"], gui_xy["btnPSAU"]["x2"], gui_xy["btnPSAU"]["y2"]), wPosSelect, BUTTON_POS_AU);
    btnPSAD = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(gui_xy["btnPSAD"]["x1"], gui_xy["btnPSAD"]["y1"], gui_xy["btnPSAD"]["x2"], gui_xy["btnPSAD"]["y2"]), wPosSelect, BUTTON_POS_AD);
    btnPSDU = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(gui_xy["btnPSDU"]["x1"], gui_xy["btnPSDU"]["y1"], gui_xy["btnPSDU"]["x2"], gui_xy["btnPSDU"]["y2"]), wPosSelect, BUTTON_POS_DU);
    btnPSDU->setImageRotation(270);
    btnPSDD = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(gui_xy["btnPSDD"]["x1"], gui_xy["btnPSDD"]["y1"], gui_xy["btnPSDD"]["x2"], gui_xy["btnPSDD"]["y2"]), wPosSelect, BUTTON_POS_DD);
    btnPSDD->setImageRotation(270);
    // card select
    wCardSelect = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wCardSelect"]["x1"], gui_xy["wCardSelect"]["y1"], gui_xy["wCardSelect"]["x2"], gui_xy["wCardSelect"]["y2"]), false, L"");
    wCardSelect->getCloseButton()->setVisible(false);
    wCardSelect->setVisible(false);
    for (int i = 0; i < 5; ++i) {
      stCardPos[i] = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(gui_xy["stCardPos"]["x1"].cast<int32_t>().value() + gui_xy["stCardPos"]["width_offset"].cast<int32_t>().value() * i, gui_xy["stCardPos"]["y1"], gui_xy["stCardPos"]["x2"].cast<int32_t>().value() + gui_xy["stCardPos"]["width_offset"].cast<int32_t>().value() * i, gui_xy["stCardPos"]["y2"]), true, false, wCardSelect, -1, true);
      stCardPos[i]->setBackgroundColor(0xffffffff);
      stCardPos[i]->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
      btnCardSelect[i] = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(gui_xy["btnCardSelect"]["x1"].cast<int64_t>().value() + gui_xy["btnCardSelect"]["width_offset"].cast<int64_t>().value() * i, gui_xy["btnCardSelect"]["y1"], gui_xy["btnCardSelect"]["x2"].cast<int64_t>().value() + gui_xy["btnCardSelect"]["width_offset"].cast<int64_t>().value() * i, gui_xy["btnCardSelect"]["y2"]), wCardSelect, BUTTON_CARD_0 + i);
      btnCardSelect[i]->setImageSize(irr::core::dimension2di(gui_xy["btnCardSelect"]["width_reduce"].cast<double>().value() * xScale, gui_xy["btnCardSelect"]["height_reduce"].cast<double>().value() * yScale));
    }
    scrCardList = guiEnv->addScrollBar(true, irr::core::rect<irr::s32>(gui_xy["scrCardList"]["x1"], gui_xy["scrCardList"]["y1"], gui_xy["scrCardList"]["x2"], gui_xy["scrCardList"]["y2"]), wCardSelect, SCROLL_CARD_SELECT);
    btnSelectOK = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnSelectOK"]["x1"], gui_xy["btnSelectOK"]["y1"], gui_xy["btnSelectOK"]["x2"], gui_xy["btnSelectOK"]["y2"]), wCardSelect, BUTTON_CARD_SEL_OK, dataManager.GetSysString(1211));
    // card display
    wCardDisplay = guiEnv->addWindow(irr::core::rect<irr::s32>(320, 100, 1000, 400), false, L"");
    wCardDisplay->getCloseButton()->setVisible(false);
    wCardDisplay->setVisible(false);
    for (int i = 0; i < 5; ++i) {
      stDisplayPos[i] = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(30 + 125 * i, 30, 150 + 125 * i, 50), true, false, wCardDisplay, -1, true);
      stDisplayPos[i]->setBackgroundColor(0xffffffff);
      stDisplayPos[i]->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
      btnCardDisplay[i] = irr::gui::CGUIImageButton::addImageButton(guiEnv, irr::core::rect<irr::s32>(30 + 125 * i, 55, 150 + 125 * i, 225), wCardDisplay, BUTTON_DISPLAY_0 + i);
      btnCardDisplay[i]->setImageSize(irr::core::dimension2di(CARD_IMG_WIDTH * 0.6f, CARD_IMG_HEIGHT * 0.6f));
    }
    scrDisplayList = guiEnv->addScrollBar(true, irr::core::rect<irr::s32>(30, 235, 650, 255), wCardDisplay, SCROLL_CARD_DISPLAY);
    btnDisplayOK = guiEnv->addButton(irr::core::rect<irr::s32>(300, 265, 380, 290), wCardDisplay, BUTTON_CARD_DISP_OK, dataManager.GetSysString(1211));

    // announce number
    wANNumber = guiEnv->addWindow(this->get_origin_rect<int32_t>("wANNumber"), false, L"");
    wANNumber->getCloseButton()->setVisible(false);
    cbANNumber = guiEnv->addComboBox(this->get_origin_rect<int32_t>("cbANNumber"), wANNumber, -1);
    btnANNumberOK = guiEnv->addButton(this->get_origin_rect<int32_t>("btnANNumberOK"), wANNumber, BUTTON_ANNUMBER_OK, dataManager.GetSysString(1211));
    wANNumber->setVisible(false);
    should_resize_element_unordered_map_int.insert_or_assign(wANNumber, "wANNumber");
    should_resize_element_unordered_map_int.insert_or_assign(cbANNumber, "cbANNumber");
    should_resize_element_unordered_map_int.insert_or_assign(btnANNumberOK, "btnANNumberOK");

    // announce card
    wANCard = guiEnv->addWindow(irr::core::rect<irr::s32>(510, 120, 820, 420), false, L"");
    wANCard->getCloseButton()->setVisible(false);
    wANCard->setVisible(false);
    ebANCard = guiEnv->addEditBox(L"", irr::core::rect<irr::s32>(20, 25, 290, 45), true, wANCard, EDITBOX_ANCARD);
    ebANCard->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    lstANCard = guiEnv->addListBox(irr::core::rect<irr::s32>(20, 50, 290, 265), wANCard, LISTBOX_ANCARD, true);
    btnANCardOK = guiEnv->addButton(irr::core::rect<irr::s32>(110, 270, 200, 295), wANCard, BUTTON_ANCARD_OK, dataManager.GetSysString(1211));
    // announce attribute
    wANAttribute = guiEnv->addWindow(this->get_origin_rect<int32_t>("wANAttribute"), false, dataManager.GetSysString(562));
    wANAttribute->getCloseButton()->setVisible(false);
    wANAttribute->setVisible(false);
    for (int filter = 0x1, i = 0; i < 7; filter <<= 1, ++i) {
      int64_t gui_xy_chkAttribute_x1 = gui_xy["chkAttribute"]["x1"];
      int64_t gui_xy_chkAttribute_y1 = gui_xy["chkAttribute"]["y1"];
      int64_t gui_xy_chkAttribute_x2 = gui_xy["chkAttribute"]["x2"];
      int64_t gui_xy_chkAttribute_y2 = gui_xy["chkAttribute"]["y2"];
      int64_t gui_xy_chkAttribute_width_offset = gui_xy["chkAttribute"]["width_offset"];
      int64_t gui_xy_chkAttribute_height_offset = gui_xy["chkAttribute"]["height_offset"];
      chkAttribute[i] = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(gui_xy_chkAttribute_x1 + (i % 4) * gui_xy_chkAttribute_width_offset, gui_xy_chkAttribute_y1 + (i / 4) * gui_xy_chkAttribute_height_offset, gui_xy_chkAttribute_x2 + (i % 4) * gui_xy_chkAttribute_width_offset, gui_xy_chkAttribute_y2 + (i / 4) * gui_xy_chkAttribute_height_offset), wANAttribute, CHECK_ATTRIBUTE, dataManager.FormatAttribute(filter).c_str());
    }
    // announce race
    wANRace = guiEnv->addWindow(get_origin_rect<int32_t>("wANRace"), false, dataManager.GetSysString(563));
    wANRace->getCloseButton()->setVisible(false);
    wANRace->setVisible(false);
    for (int filter = 0x1, i = 0; i < RACES_COUNT; filter <<= 1, ++i) {
      //~ gui_xy["chkRace"]["y2"].cast<double>().value()
      chkRace[i] = guiEnv->addCheckBox(false,
                                       irr::core::rect<irr::s32>(gui_xy["chkRace"]["x1"].cast<double>().value() + (i % 4) * (gui_xy["chkRace"]["x2"].cast<double>().value() - gui_xy["chkRace"]["x1"].cast<double>().value()), gui_xy["chkRace"]["y1"].cast<double>().value() + (i / 4) * (gui_xy["chkRace"]["y2"].cast<double>().value() - gui_xy["chkRace"]["y1"].cast<double>().value()), gui_xy["chkRace"]["x2"].cast<double>().value() + (i % 4) * (gui_xy["chkRace"]["x2"].cast<double>().value() - gui_xy["chkRace"]["x1"].cast<double>().value()),
                                                                 gui_xy["chkRace"]["y2"].cast<double>().value() + (i / 4) * (gui_xy["chkRace"]["y2"].cast<double>().value() - gui_xy["chkRace"]["y1"].cast<double>().value())),
                                       wANRace, CHECK_RACE, dataManager.FormatRace(filter).c_str());
    }
    stHintMsg = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("stHintMsg"), true, false, nullptr, -1, true);
    stHintMsg->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stHintMsg->setVisible(false);

    cmMenu = guiEnv->addContextMenu(get_origin_rect<int32_t>("0"));
    cmMenu->setCloseHandling(irr::gui::ECMC_HIDE);
    cmMenu->setVisible(false);
    // deck edit
    wDeckEdit = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("wDeckEdit"), true, false, nullptr, -1, true);
    wDeckEdit->setVisible(false);
    btnManageDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnManageDeck"), wDeckEdit, BUTTON_MANAGE_DECK, dataManager.GetSysString(1328));
    // deck manage
    wDeckManage = guiEnv->addWindow(irr::core::rect<irr::s32>(310, 135, 800, 465), false, dataManager.GetSysString(1460), nullptr, WINDOW_DECK_MANAGE);
    wDeckManage->setVisible(false);
    //~ wDeckManage->getCloseButton()->setVisible(true);
    //~ no_scale_elements.insert(wDeckManage->getCloseButton());
    lstCategories = guiEnv->addListBox(irr::core::rect<irr::s32>(10, 30, 140, 320), wDeckManage, LISTBOX_CATEGORIES, true);
    lstDecks = guiEnv->addListBox(irr::core::rect<irr::s32>(150, 30, 340, 320), wDeckManage, LISTBOX_DECKS, true);
    posY = 30;
    btnNewCategory = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_NEW_CATEGORY, dataManager.GetSysString(1461));
    posY += 35;
    btnRenameCategory = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_RENAME_CATEGORY, dataManager.GetSysString(1462));
    posY += 35;
    btnDeleteCategory = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_DELETE_CATEGORY, dataManager.GetSysString(1463));
    posY += 35;
    btnNewDeck = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_NEW_DECK, dataManager.GetSysString(1464));
    posY += 35;
    btnRenameDeck = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_RENAME_DECK, dataManager.GetSysString(1465));
    posY += 35;
    btnDMDeleteDeck = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_DELETE_DECK_DM, dataManager.GetSysString(1466));
    posY += 35;
    btnMoveDeck = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_MOVE_DECK, dataManager.GetSysString(1467));
    posY += 35;
    btnCopyDeck = guiEnv->addButton(irr::core::rect<irr::s32>(350, posY, 480, posY + 25), wDeckManage, BUTTON_COPY_DECK, dataManager.GetSysString(1468));
    // deck manage query
    wDMQuery = guiEnv->addWindow(irr::core::rect<irr::s32>(400, 200, 710, 320), false, dataManager.GetSysString(1460));
    wDMQuery->getCloseButton()->setVisible(false);
    wDMQuery->setVisible(false);
    stDMMessage = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(20, 25, 290, 45), false, false, wDMQuery);
    stDMMessage2 = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(20, 50, 290, 70), false, false, wDMQuery, -1, true);
    stDMMessage2->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    ebDMName = guiEnv->addEditBox(L"", irr::core::rect<irr::s32>(20, 50, 290, 70), true, wDMQuery, -1);
    ebDMName->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    cbDMCategory = guiEnv->addComboBox(irr::core::rect<irr::s32>(20, 50, 290, 70), wDMQuery, -1);
    stDMMessage2->setVisible(false);
    ebDMName->setVisible(false);
    cbDMCategory->setVisible(false);
    cbDMCategory->setMaxSelectionRows(10);
    btnDMOK = guiEnv->addButton(irr::core::rect<irr::s32>(70, 80, 140, 105), wDMQuery, BUTTON_DM_OK, dataManager.GetSysString(1211));
    btnDMCancel = guiEnv->addButton(irr::core::rect<irr::s32>(170, 80, 240, 105), wDMQuery, BUTTON_DM_CANCEL, dataManager.GetSysString(1212));
    //~ scrPackCards = guiEnv->addScrollBar(false, irr::core::recti(775, 161, 795, 629), nullptr, SCROLL_FILTER);
    //~ scrPackCards->setLargeStep(1);
    //~ scrPackCards->setSmallStep(1);
    //~ scrPackCards->setVisible(false);

    stDBCategory = guiEnv->addStaticText(dataManager.GetSysString(1300), get_origin_rect<int32_t>("stDBCategory"), false, false, wDeckEdit);
    cbDBCategory = guiEnv->addComboBox(get_origin_rect<int32_t>("cbDBCategory"), wDeckEdit, COMBOBOX_DBCATEGORY);
    cbDBCategory->setMaxSelectionRows(15);
    stDeck = guiEnv->addStaticText(dataManager.GetSysString(1301), get_origin_rect<int32_t>("stDeck"), false, false, wDeckEdit);
    cbDBDecks = guiEnv->addComboBox(get_origin_rect<int32_t>("cbDBDecks"), wDeckEdit, COMBOBOX_DBDECKS);
    cbDBDecks->setMaxSelectionRows(15);
    btnSaveDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnSaveDeck"), wDeckEdit, BUTTON_SAVE_DECK, dataManager.GetSysString(1302));
    ebDeckname = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebDeckname"), true, wDeckEdit, -1);
    ebDeckname->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    btnSaveDeckAs = guiEnv->addButton(get_origin_rect<int32_t>("btnSaveDeckAs"), wDeckEdit, BUTTON_SAVE_DECK_AS, dataManager.GetSysString(1303));
    btnDeleteDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnDeleteDeck"), wDeckEdit, BUTTON_DELETE_DECK, dataManager.GetSysString(1308));
    btnShuffleDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnShuffleDeck"), wDeckEdit, BUTTON_SHUFFLE_DECK, dataManager.GetSysString(1307));
    btnSortDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnSortDeck"), wDeckEdit, BUTTON_SORT_DECK, dataManager.GetSysString(1305));
    btnClearDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnClearDeck"), wDeckEdit, BUTTON_CLEAR_DECK, dataManager.GetSysString(1304));
    btnSideOK = guiEnv->addButton(irr::core::rect<irr::s32>(400, 40, 710, 80), nullptr, BUTTON_SIDE_OK, dataManager.GetSysString(1334));
    btnSideOK->setVisible(false);
    btnSideShuffle = guiEnv->addButton(irr::core::rect<irr::s32>(310, 100, 370, 130), nullptr, BUTTON_SHUFFLE_DECK, dataManager.GetSysString(1307));
    btnSideShuffle->setVisible(false);
    btnSideSort = guiEnv->addButton(irr::core::rect<irr::s32>(375, 100, 435, 130), nullptr, BUTTON_SORT_DECK, dataManager.GetSysString(1305));
    btnSideSort->setVisible(false);
    btnSideReload = guiEnv->addButton(irr::core::rect<irr::s32>(440, 100, 500, 130), nullptr, BUTTON_SIDE_RELOAD, dataManager.GetSysString(1309));
    btnSideReload->setVisible(false);
    //
    scrFilter = guiEnv->addScrollBar(false, irr::core::rect<irr::s32>(gui_xy["scrFilter"]["x1"], gui_xy["scrFilter"]["y1"], gui_xy["scrFilter"]["x2"], gui_xy["scrFilter"]["y2"]), nullptr, SCROLL_FILTER);
    scrFilter->setLargeStep(10);
    scrFilter->setSmallStep(1);
    scrFilter->setVisible(false);
    // sort type
    wSort = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("wSort"), true, false, nullptr, -1, true);
    cbSortType = guiEnv->addComboBox(get_origin_rect<int32_t>("cbSortType"), wSort, COMBOBOX_SORTTYPE);
    cbSortType->setMaxSelectionRows(10);
    for (int i = 1370; i <= 1373; i++) {
      cbSortType->addItem(dataManager.GetSysString(i));
    }
    wSort->setVisible(false);
    // filters
    wFilter = guiEnv->addStaticText(L"", get_origin_rect<int>("wFilter"), true, false, nullptr, -1, true);
    wFilter->setVisible(false);
    stCategory = guiEnv->addStaticText(dataManager.GetSysString(1311), get_origin_rect<int32_t>("stCategory"), false, false, wFilter);
    cbCardType = guiEnv->addComboBox(get_origin_rect<int32_t>("cbCardType"), wFilter, COMBOBOX_MAINTYPE);
    cbCardType->addItem(dataManager.GetSysString(1310));
    cbCardType->addItem(dataManager.GetSysString(1312));
    cbCardType->addItem(dataManager.GetSysString(1313));
    cbCardType->addItem(dataManager.GetSysString(1314));
    cbCardType2 = guiEnv->addComboBox(get_origin_rect<int32_t>("cbCardType2"), wFilter, COMBOBOX_SECONDTYPE);
    cbCardType2->setMaxSelectionRows(10);
    cbCardType2->addItem(dataManager.GetSysString(1310), 0);
    stLimit = guiEnv->addStaticText(dataManager.GetSysString(1315), get_origin_rect<int32_t>("stLimit"), false, false, wFilter);
    cbLimit = guiEnv->addComboBox(get_origin_rect<int32_t>("cbLimit"), wFilter, COMBOBOX_LIMIT);
    cbLimit->setMaxSelectionRows(10);
    cbLimit->addItem(dataManager.GetSysString(1310));
    cbLimit->addItem(dataManager.GetSysString(1316));
    cbLimit->addItem(dataManager.GetSysString(1317));
    cbLimit->addItem(dataManager.GetSysString(1318));
    cbLimit->addItem(dataManager.GetSysString(1481));
    cbLimit->addItem(dataManager.GetSysString(1482));
    cbLimit->addItem(dataManager.GetSysString(1483));
    cbLimit->addItem(dataManager.GetSysString(1484));
    cbLimit->addItem(dataManager.GetSysString(1485));
    stAttribute = guiEnv->addStaticText(dataManager.GetSysString(1319), get_origin_rect<int32_t>("stAttribute"), false, false, wFilter);
    cbAttribute = guiEnv->addComboBox(get_origin_rect<int32_t>("cbAttribute"), wFilter, COMBOBOX_ATTRIBUTE);
    cbAttribute->setMaxSelectionRows(10);
    cbAttribute->addItem(dataManager.GetSysString(1310), 0);
    for (int filter = 0x1; filter != 0x80; filter <<= 1) {
      cbAttribute->addItem(dataManager.FormatAttribute(filter).c_str(), filter);
    }
    stRace = guiEnv->addStaticText(dataManager.GetSysString(1321), get_origin_rect<int32_t>("stRace"), false, false, wFilter);
    cbRace = guiEnv->addComboBox(get_origin_rect<int32_t>("cbRace"), wFilter, COMBOBOX_RACE);
    cbRace->setMaxSelectionRows(10);
    cbRace->addItem(dataManager.GetSysString(1310), 0);
    for (int filter = 0x1; filter < (1 << RACES_COUNT); filter <<= 1) {
      cbRace->addItem(dataManager.FormatRace(filter).c_str(), filter);
    }
    stAttack = guiEnv->addStaticText(dataManager.GetSysString(1322), get_origin_rect<int32_t>("stAttack"), false, false, wFilter);
    ebAttack = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebAttack"), true, wFilter, EDITBOX_INPUTS);
    ebAttack->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stDefense = guiEnv->addStaticText(dataManager.GetSysString(1323), get_origin_rect<int32_t>("stDefense"), false, false, wFilter);
    ebDefense = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebDefense"), true, wFilter, EDITBOX_INPUTS);
    ebDefense->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stStar = guiEnv->addStaticText(dataManager.GetSysString(1324), get_origin_rect<int32_t>("stStar"), false, false, wFilter);
    ebStar = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebStar"), true, wFilter, EDITBOX_INPUTS);
    ebStar->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stScale = guiEnv->addStaticText(dataManager.GetSysString(1336), get_origin_rect<int32_t>("stScale"), false, false, wFilter);
    ebScale = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebScale"), true, wFilter, EDITBOX_INPUTS);
    ebScale->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stSearch = guiEnv->addStaticText(dataManager.GetSysString(1325), get_origin_rect<int32_t>("stSearch"), false, false, wFilter);
    ebCardName = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebCardName"), true, wFilter, EDITBOX_KEYWORD);
    ebCardName->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    //~ btnEffectFilter = guiEnv->addButton(get_origin_rect<int32_t>("btnEffectFilter"), wFilter, BUTTON_EFFECT_FILTER, dataManager.GetSysString(1326));
    btnClearFilter = guiEnv->addButton(get_origin_rect<int32_t>("btnClearFilter"), wFilter, BUTTON_CLEAR_FILTER, dataManager.GetSysString(1304));
    btnStartFilter = guiEnv->addButton(get_origin_rect<int32_t>("btnStartFilter"), wFilter, BUTTON_START_FILTER, dataManager.GetSysString(1327));

    static_text_search_record = guiEnv->addStaticText(dataManager.GetSysString(4011), get_origin_rect<int32_t>("static_text_search_record"), false, false, wFilter);
    combo_box_search_record = guiEnv->addComboBox(get_origin_rect<int32_t>("combo_box_search_record"), wFilter, combo_box_search_record_id);
    combo_box_search_record->addItem(dataManager.GetSysString(1310));

    stCategory->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stAttribute->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stRace->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    static_text_search_record->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stLimit->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stAttack->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stDefense->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stStar->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stScale->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);
    stSearch->setTextAlignment(irr::gui::EGUIA_UPPERLEFT, irr::gui::EGUIA_CENTER);

    //~ if (gameConf.separate_clear_button) {
    //~ btnStartFilter->setRelativePosition(irr::core::rect<irr::s32>(260, 80 + 125 / 6, 390, 100 + 125 / 6));
    //~ }
    //~ wCategories = guiEnv->addWindow(irr::core::rect<irr::s32>(600, 60, 1000, 305), false, L"");
    //~ wCategories->getCloseButton()->setVisible(false);
    //~ wCategories->setDrawTitlebar(false);
    //~ wCategories->setDraggable(false);
    //~ wCategories->setVisible(false);
    //~ btnCategoryOK = guiEnv->addButton(irr::core::rect<irr::s32>(150, 210, 250, 235), wCategories, BUTTON_CATEGORY_OK, dataManager.GetSysString(1211));
    //~ int catewidth = 0;
    //~ for (int i = 0; i < 32; ++i) {
    //~ irr::core::dimension2d<unsigned int> dtxt = guiFont->getDimension(dataManager.GetSysString(1100 + i));
    //~ if ((int)dtxt.Width + 40 > catewidth) {
    //~ catewidth = dtxt.Width + 40;
    //~ }
    //~ }
    //~ for (int i = 0; i < 32; ++i) {
    //~ chkCategory[i] = guiEnv->addCheckBox(false, irr::core::recti(10 + (i % 4) * catewidth, 5 + (i / 4) * 25, 10 + (i % 4 + 1) * catewidth, 5 + (i / 4 + 1) * 25), wCategories, -1, dataManager.GetSysString(1100 + i));
    //~ }
    //~ int wcatewidth = catewidth * 4 + 16;
    //~ wCategories->setRelativePosition(irr::core::rect<irr::s32>(1000 - wcatewidth, 60, 1000, 305));
    //~ btnCategoryOK->setRelativePosition(irr::core::recti(wcatewidth / 2 - 50, 210, wcatewidth / 2 + 50, 235));
    btnMarksFilter = guiEnv->addButton(get_origin_rect<int32_t>("btnMarksFilter"), wFilter, BUTTON_MARKS_FILTER, dataManager.GetSysString(1374));
    wLinkMarks = guiEnv->addWindow(irr::core::rect<irr::s32>(700, 30, 820, 150), false, L"");
    wLinkMarks->getCloseButton()->setVisible(false);
    wLinkMarks->setDrawTitlebar(false);
    wLinkMarks->setDraggable(false);
    wLinkMarks->setVisible(false);
    btnMarksOK = guiEnv->addButton(irr::core::recti(45, 45, 75, 75), wLinkMarks, BUTTON_MARKERS_OK, dataManager.GetSysString(1211));
    btnMark[0] = guiEnv->addButton(irr::core::recti(10, 10, 40, 40), wLinkMarks, -1, L"\u2196");
    btnMark[1] = guiEnv->addButton(irr::core::recti(45, 10, 75, 40), wLinkMarks, -1, L"\u2191");
    btnMark[2] = guiEnv->addButton(irr::core::recti(80, 10, 110, 40), wLinkMarks, -1, L"\u2197");
    btnMark[3] = guiEnv->addButton(irr::core::recti(10, 45, 40, 75), wLinkMarks, -1, L"\u2190");
    btnMark[4] = guiEnv->addButton(irr::core::recti(80, 45, 110, 75), wLinkMarks, -1, L"\u2192");
    btnMark[5] = guiEnv->addButton(irr::core::recti(10, 80, 40, 110), wLinkMarks, -1, L"\u2199");
    btnMark[6] = guiEnv->addButton(irr::core::recti(45, 80, 75, 110), wLinkMarks, -1, L"\u2193");
    btnMark[7] = guiEnv->addButton(irr::core::recti(80, 80, 110, 110), wLinkMarks, -1, L"\u2198");
    for (int i = 0; i < 8; i++) {
      btnMark[i]->setIsPushButton(true);
    }
    // replay window
    wReplay = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wReplay"]["x1"], gui_xy["wReplay"]["y1"], gui_xy["wReplay"]["x2"], gui_xy["wReplay"]["y2"]), false, dataManager.GetSysString(1202));
    wReplay->getCloseButton()->setVisible(false);
    wReplay->setVisible(false);
    //~ lstReplayList = guiEnv->addListBox(irr::core::rect<irr::s32>(gui_xy["lstReplayList"]["x1"], gui_xy["lstReplayList"]["y1"], gui_xy["lstReplayList"]["x2"], gui_xy["lstReplayList"]["y2"]), wReplay, LISTBOX_REPLAY_LIST, true);
    replay_file_select_panel = new irr::gui::CGUIFileSelectPanel(guiEnv, wReplay, get_origin_rect<int32_t>("replay_file_select_panel"), replay_file_select_panel_id);
    //~ lstReplayList->setItemHeight(18);

    replay_panel = addCGUIPanel(guiEnv, wReplay, -1, get_origin_rect<int32_t>("replay_panel"), false, irr::gui::ESBM_AUTOMATIC, irr::gui::ESBM_AUTOMATIC);

    btnLoadReplay = guiEnv->addButton(get_origin_rect<int32_t>("btnLoadReplay"), replay_panel, BUTTON_LOAD_REPLAY, dataManager.GetSysString(1348));
    //~ btnDeleteReplay = guiEnv->addButton(get_origin_rect<int32_t>("btnDeleteReplay"), replay_panel, BUTTON_DELETE_REPLAY, dataManager.GetSysString(1361));
    //~ btnRenameReplay = guiEnv->addButton(get_origin_rect<int32_t>("btnRenameReplay"), replay_panel, BUTTON_RENAME_REPLAY, dataManager.GetSysString(1362));
    btnReplayCancel = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayCancel"), replay_panel, BUTTON_CANCEL_REPLAY, dataManager.GetSysString(1347));
    btnExportDeck = guiEnv->addButton(get_origin_rect<int32_t>("btnExportDeck"), replay_panel, BUTTON_EXPORT_DECK, dataManager.GetSysString(1369));
    stReplayTip = guiEnv->addStaticText(dataManager.GetSysString(1349), get_origin_rect<int32_t>("stReplayTip"), false, true, wReplay);
    stReplayInfo = irr::gui::CGUIScrollText::addScrollText(guiEnv, L"", get_origin_rect<int32_t>("stReplayInfo"), false, true, wReplay);
    stReplayTurnTip = guiEnv->addStaticText(dataManager.GetSysString(1353), get_origin_rect<int32_t>("stReplayTurnTip"), false, true, replay_panel);
    ebRepStartTurn = guiEnv->addEditBox(L"", get_origin_rect<int32_t>("ebRepStartTurn"), true, replay_panel, -1);
    //~ cc.gc w a
    //~ replay_panel->addChild($a.1);
    //~ cc.p
    replay_panel->addChild(btnLoadReplay);
    //~ replay_panel->addChild(btnDeleteReplay);
    //~ replay_panel->addChild(btnRenameReplay);
    replay_panel->addChild(btnReplayCancel);
    replay_panel->addChild(btnExportDeck);
    //~ replay_panel->addChild(stReplayTip);
    //~ replay_panel->addChild(stReplayInfo);
    replay_panel->addChild(stReplayTurnTip);
    replay_panel->addChild(ebRepStartTurn);
    ebRepStartTurn->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);

    check_single_replay_button = guiEnv->addButton(get_origin_rect<int32_t>("check_single_replay_button"), replay_panel, check_single_replay_button_id, dataManager.GetSysString(4000));
    check_single_layer_replay_button = guiEnv->addButton(get_origin_rect<int32_t>("check_single_layer_replay_button"), replay_panel, check_single_layer_replay_button_id, dataManager.GetSysString(4001));
    check_multi_layer_replay_button = guiEnv->addButton(get_origin_rect<int32_t>("check_multi_layer_replay_button"), replay_panel, check_multi_layer_replay_button_id, dataManager.GetSysString(4002));
    solve_puzzle_button = guiEnv->addButton(get_origin_rect<int32_t>("solve_puzzle_button"), replay_panel, solve_puzzle_button_id, dataManager.GetSysString(4009));
    as_puzzle_button = guiEnv->addButton(get_origin_rect<int32_t>("as_puzzle_button"), replay_panel, as_puzzle_button_id, dataManager.GetSysString(4010));

    replay_panel->addChild(check_single_replay_button);
    replay_panel->addChild(check_single_layer_replay_button);
    replay_panel->addChild(check_multi_layer_replay_button);
    replay_panel->addChild(solve_puzzle_button);
    replay_panel->addChild(as_puzzle_button);

    check_replay_window = guiEnv->addWindow(get_origin_rect<int32_t>("check_replay_window"), false, dataManager.GetSysString(4003));
    //~ check_replay_table = guiEnv->addTable(get_origin_rect<int32_t>("check_replay_table"), check_replay_window);
    check_replay_table = guiEnv->addTable(irr::core::rect<int32_t>(0, 0, 0, 0), check_replay_window);
    check_replay_table->addColumn(L"id");
    check_replay_table->addColumn(dataManager.GetSysString(4004));
    check_replay_table->addColumn(dataManager.GetSysString(4005));
    check_replay_table->addColumn(dataManager.GetSysString(4006));
    check_replay_table->setColumnOrdering(0, irr::gui::EGCO_FLIP_ASCENDING_DESCENDING);
    check_replay_table->setColumnOrdering(1, irr::gui::EGCO_FLIP_ASCENDING_DESCENDING);
    check_replay_table->setColumnOrdering(2, irr::gui::EGCO_FLIP_ASCENDING_DESCENDING);
    check_replay_table->setColumnOrdering(3, irr::gui::EGCO_FLIP_ASCENDING_DESCENDING);
    check_replay_window->setVisible(false);
    check_replay_window->getCloseButton()->setVisible(false);
    //~ check_replay_window->getMinimizeButton()->setVisible(true);
    check_replay_static_text = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("check_replay_static_text"), false, false, check_replay_window);

    solve_puzzle_window = guiEnv->addWindow(get_origin_rect<int32_t>("solve_puzzle_window"), false, dataManager.GetSysString(4009));
    //~ solve_puzzle_table = guiEnv->addTable(get_origin_rect<int32_t>("solve_puzzle_table"), solve_puzzle_window);
    //~ solve_puzzle_table->addColumn(dataManager.GetSysString(4004));
    //~ solve_puzzle_table->addColumn(dataManager.GetSysString(4005));
    //~ solve_puzzle_table->addColumn(dataManager.GetSysString(4006));

    solve_puzzle_window->setVisible(false);

    // single play window
    wSinglePlay = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wSinglePlay"]["x1"], gui_xy["wSinglePlay"]["y1"], gui_xy["wSinglePlay"]["x2"], gui_xy["wSinglePlay"]["y2"]), false, dataManager.GetSysString(1201));
    wSinglePlay->getCloseButton()->setVisible(false);
    wSinglePlay->setVisible(false);
    wSingle = guiEnv->addTabControl(irr::core::rect<irr::s32>(gui_xy["wSingle"]["x1"], gui_xy["wSingle"]["y1"], gui_xy["wSingle"]["x2"], gui_xy["wSingle"]["y2"]), wSinglePlay, true);
    tabSingle = wSingle->addTab(dataManager.GetSysString(1381));
    if (gameConf.enable_bot_mode) {
      tabBot = wSingle->addTab(dataManager.GetSysString(1380));
      lstBotList = guiEnv->addListBox(irr::core::rect<irr::s32>(gui_xy["lstBotList"]["x1"], gui_xy["lstBotList"]["y1"], gui_xy["lstBotList"]["x2"], gui_xy["lstBotList"]["y2"]), tabBot, LISTBOX_BOT_LIST, true);
      lstBotList->setItemHeight(18);
      btnStartBot = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnStartBot"]["x1"], gui_xy["btnStartBot"]["y1"], gui_xy["btnStartBot"]["x2"], gui_xy["btnStartBot"]["y2"]), tabBot, BUTTON_BOT_START, dataManager.GetSysString(1211));
      btnBotCancel = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnBotCancel"]["x1"], gui_xy["btnBotCancel"]["y1"], gui_xy["btnBotCancel"]["x2"], gui_xy["btnBotCancel"]["y2"]), tabBot, BUTTON_CANCEL_SINGLEPLAY, dataManager.GetSysString(1210));
      stBotTip = guiEnv->addStaticText(dataManager.GetSysString(1382), irr::core::rect<irr::s32>(gui_xy["stBotTip"]["x1"], gui_xy["stBotTip"]["y1"], gui_xy["stBotTip"]["x2"], gui_xy["stBotTip"]["y2"]), false, true, tabBot);
      stBotInfo = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(gui_xy["stBotInfo"]["x1"], gui_xy["stBotInfo"]["y1"], gui_xy["stBotInfo"]["x2"], gui_xy["stBotInfo"]["y2"]), false, true, tabBot);
      cbBotDeckCategory = guiEnv->addComboBox(irr::core::rect<irr::s32>(gui_xy["cbBotDeckCategory"]["x1"], gui_xy["cbBotDeckCategory"]["y1"], gui_xy["cbBotDeckCategory"]["x2"], gui_xy["cbBotDeckCategory"]["y2"]), tabBot, COMBOBOX_BOT_DECKCATEGORY);
      cbBotDeckCategory->setMaxSelectionRows(6);
      cbBotDeckCategory->setVisible(false);
      cbBotDeck = guiEnv->addComboBox(irr::core::rect<irr::s32>(gui_xy["cbBotDeck"]["x1"], gui_xy["cbBotDeck"]["y1"], gui_xy["cbBotDeck"]["x2"], gui_xy["cbBotDeck"]["y2"]), tabBot);
      cbBotDeck->setMaxSelectionRows(6);
      cbBotDeck->setVisible(false);
      cbBotRule = guiEnv->addComboBox(irr::core::rect<irr::s32>(gui_xy["cbBotRule"]["x1"], gui_xy["cbBotRule"]["y1"], gui_xy["cbBotRule"]["x2"], gui_xy["cbBotRule"]["y2"]), tabBot, COMBOBOX_BOT_RULE);
      cbBotRule->addItem(dataManager.GetSysString(1262));
      cbBotRule->addItem(dataManager.GetSysString(1263));
      cbBotRule->addItem(dataManager.GetSysString(1264));
      cbBotRule->setSelected(gameConf.default_rule - 3);
      chkBotHand = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(gui_xy["chkBotHand"]["x1"], gui_xy["chkBotHand"]["y1"], gui_xy["chkBotHand"]["x2"], gui_xy["chkBotHand"]["y2"]), tabBot, -1, dataManager.GetSysString(1384));
      chkBotNoCheckDeck = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(gui_xy["chkBotNoCheckDeck"]["x1"], gui_xy["chkBotNoCheckDeck"]["y1"], gui_xy["chkBotNoCheckDeck"]["x2"], gui_xy["chkBotNoCheckDeck"]["y2"]), tabBot, -1, dataManager.GetSysString(1229));
      chkBotNoShuffleDeck = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(gui_xy["chkBotNoShuffleDeck"]["x1"], gui_xy["chkBotNoShuffleDeck"]["y1"], gui_xy["chkBotNoShuffleDeck"]["x2"], gui_xy["chkBotNoShuffleDeck"]["y2"]), tabBot, -1, dataManager.GetSysString(1230));
    }
    else { // avoid null pointer
      btnStartBot = guiEnv->addButton(irr::core::rect<irr::s32>(0, 0, 0, 0), wSinglePlay);
      btnBotCancel = guiEnv->addButton(irr::core::rect<irr::s32>(0, 0, 0, 0), wSinglePlay);
      btnStartBot->setVisible(false);
      btnBotCancel->setVisible(false);
    }
    single_file_select_panel = new irr::gui::CGUIFileSelectPanel(guiEnv, tabSingle, get_origin_rect<int32_t>("single_file_select_panel"), single_file_select_panel_id);
    btnLoadSinglePlay = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnLoadSinglePlay"]["x1"], gui_xy["btnLoadSinglePlay"]["y1"], gui_xy["btnLoadSinglePlay"]["x2"], gui_xy["btnLoadSinglePlay"]["y2"]), tabSingle, BUTTON_LOAD_SINGLEPLAY, dataManager.GetSysString(1211));
    btnSinglePlayCancel = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnSinglePlayCancel"]["x1"], gui_xy["btnSinglePlayCancel"]["y1"], gui_xy["btnSinglePlayCancel"]["x2"], gui_xy["btnSinglePlayCancel"]["y2"]), tabSingle, BUTTON_CANCEL_SINGLEPLAY, dataManager.GetSysString(1210));
    stSinglePlayTip = guiEnv->addStaticText(dataManager.GetSysString(1352), irr::core::rect<irr::s32>(gui_xy["stSinglePlayTip"]["x1"], gui_xy["stSinglePlayTip"]["y1"], gui_xy["stSinglePlayTip"]["x2"], gui_xy["stSinglePlayTip"]["y2"]), false, true, tabSingle);
    stSinglePlayInfo = irr::gui::CGUIScrollText::addScrollText(guiEnv, L"", irr::core::rect<irr::s32>(gui_xy["stSinglePlayInfo"]["x1"], gui_xy["stSinglePlayInfo"]["y1"], gui_xy["stSinglePlayInfo"]["x2"], gui_xy["stSinglePlayInfo"]["y2"]), false, true, tabSingle);
    chkSinglePlayReturnDeckTop = guiEnv->addCheckBox(false, irr::core::rect<irr::s32>(gui_xy["chkSinglePlayReturnDeckTop"]["x1"], gui_xy["chkSinglePlayReturnDeckTop"]["y1"], gui_xy["chkSinglePlayReturnDeckTop"]["x2"], gui_xy["chkSinglePlayReturnDeckTop"]["y2"]), tabSingle, -1, dataManager.GetSysString(1238));
    // replay save
    wReplaySave = guiEnv->addWindow(irr::core::rect<irr::s32>(gui_xy["wReplaySave"]["x1"], gui_xy["wReplaySave"]["y1"], gui_xy["wReplaySave"]["x2"], gui_xy["wReplaySave"]["y2"]), false, dataManager.GetSysString(1340));
    wReplaySave->getCloseButton()->setVisible(false);
    wReplaySave->setVisible(false);
    stReplaySave = guiEnv->addStaticText(dataManager.GetSysString(1342), irr::core::rect<irr::s32>(gui_xy["stReplaySave"]["x1"], gui_xy["stReplaySave"]["y1"], gui_xy["stReplaySave"]["x2"], gui_xy["stReplaySave"]["y2"]), false, false, wReplaySave);
    ebRSName = guiEnv->addEditBox(L"", irr::core::rect<irr::s32>(gui_xy["ebRSName"]["x1"], gui_xy["ebRSName"]["y1"], gui_xy["ebRSName"]["x2"], gui_xy["ebRSName"]["y2"]), true, wReplaySave, -1);
    ebRSName->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    //~ btnRSYes = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnRSYes"]["x1"], gui_xy["btnRSYes"]["y1"], gui_xy["btnRSYes"]["x2"], gui_xy["btnRSYes"]["y2"]), wReplaySave, BUTTON_REPLAY_SAVE, dataManager.GetSysString(1341));
    btnRSNo = guiEnv->addButton(irr::core::rect<irr::s32>(gui_xy["btnRSNo"]["x1"], gui_xy["btnRSNo"]["y1"], gui_xy["btnRSNo"]["x2"], gui_xy["btnRSNo"]["y2"]), wReplaySave, BUTTON_REPLAY_CANCEL, dataManager.GetSysString(1212));
    // replay control
    wReplayControl = guiEnv->addStaticText(L"", get_origin_rect<int32_t>("wReplayControl"), true, false, nullptr, -1, true);
    wReplayControl->setVisible(false);
    btnReplayStart = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayStart"), wReplayControl, BUTTON_REPLAY_START, dataManager.GetSysString(1343));
    btnReplayPause = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayPause"), wReplayControl, BUTTON_REPLAY_PAUSE, dataManager.GetSysString(1344));
    btnReplayStep = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayStep"), wReplayControl, BUTTON_REPLAY_STEP, dataManager.GetSysString(1345));
    btnReplayUndo = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayUndo"), wReplayControl, BUTTON_REPLAY_UNDO, dataManager.GetSysString(1360));
    btnReplaySwap = guiEnv->addButton(get_origin_rect<int32_t>("btnReplaySwap"), wReplayControl, BUTTON_REPLAY_SWAP, dataManager.GetSysString(1346));
    btnReplayExit = guiEnv->addButton(get_origin_rect<int32_t>("btnReplayExit"), wReplayControl, BUTTON_REPLAY_EXIT, dataManager.GetSysString(1347));
    // chat
    wChat = guiEnv->addWindow(irr::core::rect<irr::s32>(305, 615, 1020, 640), false, L"");
    wChat->getCloseButton()->setVisible(false);
    wChat->setDraggable(false);
    wChat->setDrawTitlebar(false);
    wChat->setVisible(false);
    ebChatInput = guiEnv->addEditBox(L"", irr::core::rect<irr::s32>(3, 2, 710, 22), true, wChat, EDITBOX_CHAT);
    // swap
    btnSpectatorSwap = guiEnv->addButton(irr::core::rect<irr::s32>(205, 100, 295, 135), nullptr, BUTTON_REPLAY_SWAP, dataManager.GetSysString(1346));
    btnSpectatorSwap->setVisible(false);

    chain_timing_combo_box = guiEnv->addComboBox(get_origin_rect<int32_t>("chain_timing_combo_box"), 0, chain_timing_combo_box_id);
    chain_timing_combo_box->addItem(dataManager.GetSysString(1310));
    chain_timing_combo_box->addItem(dataManager.GetSysString(1292));
    chain_timing_combo_box->addItem(dataManager.GetSysString(1293));
    chain_timing_combo_box->addItem(dataManager.GetSysString(1294));
    chain_timing_combo_box->setVisible(false);

    // chain buttons
    btnChainIgnore = guiEnv->addButton(irr::core::rect<irr::s32>(205, 100, 295, 135), nullptr, BUTTON_CHAIN_IGNORE, dataManager.GetSysString(1292));
    btnChainAlways = guiEnv->addButton(irr::core::rect<irr::s32>(205, 140, 295, 175), nullptr, BUTTON_CHAIN_ALWAYS, dataManager.GetSysString(1293));
    btnChainWhenAvail = guiEnv->addButton(irr::core::rect<irr::s32>(205, 180, 295, 215), nullptr, BUTTON_CHAIN_WHENAVAIL, dataManager.GetSysString(1294));
    btnChainIgnore->setIsPushButton(true);
    btnChainAlways->setIsPushButton(true);
    btnChainWhenAvail->setIsPushButton(true);
    btnChainIgnore->setVisible(false);
    btnChainAlways->setVisible(false);
    btnChainWhenAvail->setVisible(false);
    // shuffle
    btnShuffle = guiEnv->addButton(irr::core::rect<irr::s32>(205, 230, 295, 265), nullptr, BUTTON_CMD_SHUFFLE, dataManager.GetSysString(1297));
    btnShuffle->setVisible(false);
    // cancel or finish
    btnCancelOrFinish = guiEnv->addButton(irr::core::rect<irr::s32>(205, 230, 295, 265), nullptr, BUTTON_CANCEL_OR_FINISH, dataManager.GetSysString(1295));
    btnCancelOrFinish->setVisible(false);
    // big picture
    wBigCard = guiEnv->addWindow(irr::core::rect<irr::s32>(0, 0, 0, 0), false, L"");
    wBigCard->getCloseButton()->setVisible(false);
    wBigCard->setDrawTitlebar(false);
    wBigCard->setDrawBackground(false);
    wBigCard->setVisible(false);
    imgBigCard = guiEnv->addImage(irr::core::rect<irr::s32>(0, 0, 0, 0), wBigCard);
    imgBigCard->setScaleImage(false);
    imgBigCard->setUseAlphaChannel(true);
    //~ btnBigCardOriginalSize = guiEnv->addButton(irr::core::rect<irr::s32>(205, 100, 295, 135), nullptr, BUTTON_BIG_CARD_ORIG_SIZE, dataManager.GetSysString(1443));
    //~ btnBigCardZoomIn = guiEnv->addButton(irr::core::rect<irr::s32>(205, 140, 295, 175), nullptr, BUTTON_BIG_CARD_ZOOM_IN, dataManager.GetSysString(1441));
    //~ btnBigCardZoomOut = guiEnv->addButton(irr::core::rect<irr::s32>(205, 180, 295, 215), nullptr, BUTTON_BIG_CARD_ZOOM_OUT, dataManager.GetSysString(1442));
    //~ btnBigCardClose = guiEnv->addButton(irr::core::rect<irr::s32>(205, 230, 295, 265), nullptr, BUTTON_BIG_CARD_CLOSE, dataManager.GetSysString(1440));
    //~ btnBigCardOriginalSize->setVisible(false);
    //~ btnBigCardZoomIn->setVisible(false);
    //~ btnBigCardZoomOut->setVisible(false);
    //~ btnBigCardClose->setVisible(false);
    // leave/surrender/exit
    btnLeaveGame = guiEnv->addButton(get_origin_rect<int32_t>("btnLeaveGame"), nullptr, BUTTON_LEAVE_GAME, L"");
    btnLeaveGame->setVisible(false);
    // tip
    stTip = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(0, 0, 150, 150), false, true, nullptr, -1, true);
    //~ stTip->setBackgroundColor(0xc0ffffff);
    stTip->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stTip->setVisible(false);
    // tip for cards in select / display list
    stCardListTip = guiEnv->addStaticText(L"", irr::core::rect<irr::s32>(0, 0, 150, 150), false, false, wCardSelect, TEXT_CARD_LIST_TIP, true);
    //~ stCardListTip->setBackgroundColor(0xc0ffffff);
    stCardListTip->setTextAlignment(irr::gui::EGUIA_CENTER, irr::gui::EGUIA_CENTER);
    stCardListTip->setVisible(false);
    device->setEventReceiver(&menuHandler);
    if (!soundManager.Init()) {
      chkEnableSound->setChecked(false);
      chkEnableSound->setEnabled(false);
      chkEnableSound->setVisible(false);
      chkEnableMusic->setChecked(false);
      chkEnableMusic->setEnabled(false);
      chkEnableMusic->setVisible(false);
      scrSoundVolume->setVisible(false);
      scrMusicVolume->setVisible(false);
      chkMusicMode->setEnabled(false);
      chkMusicMode->setVisible(false);
    }
    //~ guiEnv->getSkin()->setFont(guiFont);
    guiEnv->setFocus(wMainMenu);

    init_resize_element_unordered_map();

    irr::core::dimension2du size = driver->getScreenSize();
    if (window_size != size) {
      window_size = size;
      xScale = window_size.Width / 1024.0;
      yScale = window_size.Height / 640.0;
      OnResize();
    }

    return true;
  }

  void Game::resize_skin() {
    auto gui_skin = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "skin");
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "config");

    for (int64_t i = 0, n = irr::gui::EGDC_COUNT; i != n; ++i) {
      auto col = static_cast<int64_t>(gui_skin[i]);
      guiEnv->getSkin()->setColor(static_cast<irr::gui::EGUI_DEFAULT_COLOR>(i), col);
    }
    double scrollbar_witdh = gui_config["scrollbar_witdh"];
    double window_button_width = gui_config["window_button_width"];
    double menu_height = gui_config["menu_height"];
    guiEnv->getSkin()->setSize(irr::gui::EGDS_SCROLLBAR_SIZE, scrollbar_witdh * xScale);
    guiEnv->getSkin()->setSize(irr::gui::EGDS_WINDOW_BUTTON_WIDTH, window_button_width * xScale);
    guiEnv->getSkin()->setSize(irr::gui::EGDS_MENU_HEIGHT, menu_height * xScale);
  }

  void Game::MainLoop() {
    wchar_t cap[256];
    camera = smgr->addCameraSceneNode(nullptr);
    irr::core::matrix4 mProjection;
    BuildProjectionMatrix(mProjection, -0.90f, 0.45f, -0.42f, 0.42f, 1.0f, 100.0f);
    camera->setProjectionMatrix(mProjection);

    mProjection.buildCameraLookAtMatrixLH(irr::core::vector3df(4.2f, 8.0f, 7.8f), irr::core::vector3df(4.2f, 0, 0), irr::core::vector3df(0, 0, 1));
    camera->setViewMatrixAffector(mProjection);
    smgr->setAmbientLight(irr::video::SColorf(1.0f, 1.0f, 1.0f));
    float atkframe = 0.1f;
    irr::ITimer *timer = device->getTimer();
    timer->setTime(0);
    int fps = 0;
    int cur_time = 0;
    while (device->run()) {
      irr::core::dimension2du size = driver->getScreenSize();
      if (window_size != size) {
        last_x_scale = window_size.Width / 1024.0;
        last_y_scale = window_size.Height / 640.0;
        window_size = size;
        xScale = window_size.Width / 1024.0;
        yScale = window_size.Height / 640.0;
        OnResize();
      }
      linePatternD3D = (linePatternD3D + 1) % 30;
      linePatternGL = (linePatternGL << 1) | (linePatternGL >> 15);
      atkframe += 0.1f;
      atkdy = sin(atkframe);
      driver->beginScene(true, true, irr::video::SColor(0, 0, 0, 0));
      gMutex.lock();
      if (dInfo.isStarted) {
        if (dInfo.isFinished && showcardcode == 1) {
          soundManager.PlayBGM(BGM_WIN);
        }
        else if (dInfo.isFinished && (showcardcode == 2 || showcardcode == 3)) {
          soundManager.PlayBGM(BGM_LOSE);
        }
        else if (dInfo.lp[0] > 0 && dInfo.lp[0] <= dInfo.lp[1] / 2) {
          soundManager.PlayBGM(BGM_DISADVANTAGE);
        }
        else if (dInfo.lp[0] > 0 && dInfo.lp[0] >= dInfo.lp[1] * 2) {
          soundManager.PlayBGM(BGM_ADVANTAGE);
        }
        else {
          soundManager.PlayBGM(BGM_DUEL);
        }
        DrawBackImage(imageManager.tBackGround);
        DrawBackGround();
        DrawCards();
        DrawMisc();
        smgr->drawAll();
        driver->setMaterial(irr::video::IdentityMaterial);
        driver->clearZBuffer();
      }
      else if (is_building) {
        soundManager.PlayBGM(BGM_DECK);
        DrawBackImage(imageManager.tBackGround_deck);
        DrawDeckBd();
      }
      else {
        soundManager.PlayBGM(BGM_MENU);
        DrawBackImage(imageManager.tBackGround_menu);
      }
      DrawGUI();
      DrawSpec();
      gMutex.unlock();
      if (signalFrame > 0) {
        signalFrame--;
        if (!signalFrame) {
          frameSignal.Set();
        }
      }
      if (waitFrame >= 0) {
        waitFrame++;
        if (waitFrame % 90 == 0) {
          stHintMsg->setText(dataManager.GetSysString(1390));
        }
        else if (waitFrame % 90 == 30) {
          stHintMsg->setText(dataManager.GetSysString(1391));
        }
        else if (waitFrame % 90 == 60) {
          stHintMsg->setText(dataManager.GetSysString(1392));
        }
      }
      driver->endScene();
      if (closeSignal.Wait(1)) {
        CloseDuelWindow();
      }
      fps++;
      //~ fast_io::perrln(wDeckManage->getCloseButton()->isVisible());
      cur_time = timer->getTime();
      if (cur_time < fps * 17 - 20) {
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
      }
      if (cur_time >= 1000) {
        myswprintf(cap, L"EDOPro FPS: %d", fps);
        device->setWindowCaption(cap);
        fps = 0;
        cur_time -= 1000;
        timer->setTime(0);
        if (dInfo.time_player == 0 || dInfo.time_player == 1) {
          if (dInfo.time_left[dInfo.time_player]) {
            dInfo.time_left[dInfo.time_player]--;
          }
        }
      }
    }
    DuelClient::StopClient(true);
    if (dInfo.isSingleMode) {
      SingleMode::StopPlay(true);
    }
    std::this_thread::sleep_for(std::chrono::milliseconds(500));
    SaveConfig();
    device->drop();
  }

  void Game::BuildProjectionMatrix(irr::core::matrix4 &mProjection, irr::f32 left, irr::f32 right, irr::f32 bottom, irr::f32 top, irr::f32 znear, irr::f32 zfar) {
    for (int i = 0; i < 16; ++i) {
      mProjection[i] = 0;
    }
    mProjection[0] = 2.0f * znear / (right - left);
    mProjection[5] = 2.0f * znear / (top - bottom);
    mProjection[8] = (left + right) / (left - right);
    mProjection[9] = (top + bottom) / (bottom - top);
    mProjection[10] = zfar / (zfar - znear);
    mProjection[11] = 1.0f;
    mProjection[14] = znear * zfar / (znear - zfar);
  }

  void Game::InitStaticText(irr::gui::IGUIStaticText *pControl, irr::u32 cWidth, irr::u32 cHeight, irr::gui::CGUITTFont *font, const wchar_t *text) {
    std::wstring format_text;
    format_text = SetStaticText(pControl, cWidth, font, text);
  }

  irr::gui::IGUIWindow *Game::addWindow(const irr::core::rect<irr::s32> &rectangle, bool modal, const wchar_t *text, irr::gui::IGUIElement *parent, irr::s32 id) {
    auto *k1 = guiEnv->addWindow(rectangle, modal, text, parent, id);
    no_scale_elements.insert(k1->getCloseButton());
    return k1;
  }

  irr::gui::CGUIPanel *Game::addCGUIPanel(irr::gui::IGUIEnvironment *environment, irr::gui::IGUIElement *parent, irr::s32 id, const irr::core::rect<irr::s32> &rectangle, bool border, irr::gui::E_SCROLL_BAR_MODE vMode, irr::gui::E_SCROLL_BAR_MODE hMode) {
    auto *k1 = new irr::gui::CGUIPanel(environment, parent, id, rectangle, border, vMode, hMode);
    no_scale_elements.insert(k1->getVScrollBar());
    no_scale_elements.insert(k1->getHScrollBar());
    return k1;
  }

  std::wstring Game::SetStaticText(irr::gui::IGUIStaticText *pControl, irr::u32 cWidth, irr::gui::CGUITTFont *font, const wchar_t *text, irr::u32 pos) {
    int pbuffer = 0;
    irr::u32 _width = 0;
    irr::u32 _height = 0;
    wchar_t prev = 0;
    wchar_t strBuffer[4096];
    std::wstring ret;

    for (size_t i = 0; text[i] != 0 && i < std::wcslen(text); ++i) {
      const wchar_t c = text[i];
      irr::u32 w = font->getCharDimension(c).Width + font->getKerningWidth(&c, &prev);
      prev = c;
      if (text[i] == L'\r') {
        continue;
      }
      else if (text[i] == L'\n') {
        strBuffer[pbuffer++] = L'\n';
        _width = 0;
        _height++;
        prev = 0;
        if (_height == pos) {
          pbuffer = 0;
        }
        continue;
      }
      else if (_width > 0 && _width + w > cWidth) {
        strBuffer[pbuffer++] = L'\n';
        _width = 0;
        _height++;
        prev = 0;
        if (_height == pos) {
          pbuffer = 0;
        }
      }
      _width += w;
      strBuffer[pbuffer++] = c;
    }
    strBuffer[pbuffer] = 0;
    if (pControl) {
      pControl->setText(strBuffer);
      //~ pControl->setToolTipText(strBuffer);
    }
    ret.assign(strBuffer);
    return ret;
  }

  void Game::LoadExpansions() {
    FileSystem::TraversalDir(L"./expansions", [](const wchar_t *name, bool isdir) {
      if (isdir) {
        return;
      }
      //~ fast_io::io::print(fast_io::win32_box_t(), fast_io::mnp::code_cvt_os_c_str(name), "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      wchar_t fpath[1024];
      myswprintf(fpath, L"./expansions/%ls", name);
      if (IsExtension(name, L".cdb")) {
        dataManager.LoadDB(fpath);
        return;
      }
      if (IsExtension(name, L".conf")) {
        char upath[1024];
        BufferIO::EncodeUTF8(fpath, upath);
        dataManager.LoadStrings(upath);
        return;
      }
      if (IsExtension(name, L".zip") || IsExtension(name, L".ypk")) {
        DataManager::FileSystem->addFileArchive(fpath, true, false, irr::io::EFAT_ZIP);
        return;
      }
    });
    for (irr::u32 i = 0; i < DataManager::FileSystem->getFileArchiveCount(); ++i) {
      const irr::io::IFileList *archive = DataManager::FileSystem->getFileArchive(i)->getFileList();
      for (irr::u32 j = 0; j < archive->getFileCount(); ++j) {
        const wchar_t *fname = archive->getFullFileName(j).c_str();
        if (IsExtension(fname, L".cdb")) {
          dataManager.LoadDB(fname);
          continue;
        }
        if (IsExtension(fname, L".conf")) {
          auto *reader = DataManager::FileSystem->createAndOpenFile(fname);
          dataManager.LoadStrings(reader);
          continue;
        }
        if (!mywcsncasecmp(fname, L"pack/", 5) && IsExtension(fname, L".ydk")) {
          deckBuilder.expansionPacks.push_back(fname);
          continue;
        }
      }
    }
  }

  void Game::RefreshCategoryDeck(irr::gui::IGUIComboBox *cbCategory, irr::gui::IGUIComboBox *cbDeck, bool selectlastused) {
    cbCategory->clear();
    cbCategory->addItem(dataManager.GetSysString(1450));
    cbCategory->addItem(dataManager.GetSysString(1451));
    cbCategory->addItem(dataManager.GetSysString(1452));
    cbCategory->addItem(dataManager.GetSysString(1453));
    FileSystem::TraversalDir(L"./deck", [cbCategory](const wchar_t *name, bool isdir) {
      if (isdir) {
        cbCategory->addItem(name);
      }
    });
    cbCategory->setSelected(2);
    if (selectlastused) {
      for (size_t i = 0; i < cbCategory->getItemCount(); ++i) {
        if (!std::wcscmp(cbCategory->getItem(i), gameConf.lastcategory)) {
          cbCategory->setSelected(i);
          break;
        }
      }
    }
    RefreshDeck(cbCategory, cbDeck);
    if (selectlastused) {
      for (size_t i = 0; i < cbDeck->getItemCount(); ++i) {
        if (!std::wcscmp(cbDeck->getItem(i), gameConf.lastdeck)) {
          cbDeck->setSelected(i);
          break;
        }
      }
    }
  }

  void Game::RefreshDeck(irr::gui::IGUIComboBox *cbCategory, irr::gui::IGUIComboBox *cbDeck) {
    if (cbCategory != cbDBCategory && cbCategory->getSelected() == 0) {
      // can't use pack list in duel
      cbDeck->clear();
      return;
    }
    wchar_t catepath[256];
    DeckManager::GetCategoryPath(catepath, cbCategory->getSelected(), cbCategory->getText());
    cbDeck->clear();
    RefreshDeck(catepath, [cbDeck](const wchar_t *item) {
      cbDeck->addItem(item);
    });
  }

  void Game::RefreshDeck(const wchar_t *deckpath, const std::function<void(const wchar_t *)> &additem) {
    if (!mywcsncasecmp(deckpath, L"./pack", 6)) {
      for (auto &pack : deckBuilder.expansionPacks) {
        // add pack/xxx.ydk
        additem(pack.substr(5, pack.size() - 9).c_str());
      }
    }
    FileSystem::TraversalDir(deckpath, [additem](const wchar_t *name, bool isdir) {
      if (!isdir && IsExtension(name, L".ydk")) {
        size_t len = std::wcslen(name);
        wchar_t deckname[256]{};
        size_t count = std::min(len - 4, sizeof deckname / sizeof deckname[0] - 1);
        std::wcsncpy(deckname, name, count);
        deckname[count] = 0;
        additem(deckname);
      }
    });
  }

  void Game::RefreshReplay() {
    using fast_io::wconcat_std;
    using fast_io::mnp::code_cvt;
    using luabridge::getGlobal;
    using luabridge::main_thread;

    auto gui_config = getGlobal(main_thread(this->get_lua(boost::this_thread::get_id())), "config");
    auto replay_dir = wconcat_std(code_cvt(gui_config["replay_dir"].tostring()));
    auto replay_file_suffix = wconcat_std(L".", code_cvt(gui_config["replay_file_suffix"].tostring()));

    mainGame->replay_file_select_panel->setWorkingDir(replay_dir.c_str(), replay_file_suffix.c_str());
  }

  void Game::RefreshSingleplay() {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "config");
    stSinglePlayInfo->setText(L"");
    fast_io::wstring str = fast_io::wconcat_fast_io(fast_io::mnp::code_cvt(gui_config["single_dir"].tostring()));
    single_file_select_panel->setWorkingDir(str.c_str(), L"lua");
  }

  void Game::RefreshBot() {
    if (!gameConf.enable_bot_mode) {
      return;
    }
    botInfo.clear();
    FILE *fp = std::fopen("bot.conf", "r");
    char linebuf[256]{};
    char strbuf[256]{};
    if (fp) {
      while (std::fgets(linebuf, 256, fp)) {
        if (linebuf[0] == '#') {
          continue;
        }
        if (linebuf[0] == '!') {
          BotInfo newinfo;
          if (std::sscanf(linebuf, "!%240[^\n]", strbuf) != 1) {
            continue;
          }
          BufferIO::DecodeUTF8(strbuf, newinfo.name);
          if (!std::fgets(linebuf, 256, fp)) {
            break;
          }
          if (std::sscanf(linebuf, "%240[^\n]", strbuf) != 1) {
            continue;
          }
          BufferIO::DecodeUTF8(strbuf, newinfo.command);
          if (!std::fgets(linebuf, 256, fp)) {
            break;
          }
          if (std::sscanf(linebuf, "%240[^\n]", strbuf) != 1) {
            continue;
          }
          BufferIO::DecodeUTF8(strbuf, newinfo.desc);
          if (!std::fgets(linebuf, 256, fp)) {
            break;
          }
          newinfo.support_master_rule_3 = !!std::strstr(linebuf, "SUPPORT_MASTER_RULE_3");
          newinfo.support_new_master_rule = !!std::strstr(linebuf, "SUPPORT_NEW_MASTER_RULE");
          newinfo.support_master_rule_2020 = !!std::strstr(linebuf, "SUPPORT_MASTER_RULE_2020");
          newinfo.select_deckfile = !!std::strstr(linebuf, "SELECT_DECKFILE");
          int rule = cbBotRule->getSelected() + 3;
          if ((rule == 3 && newinfo.support_master_rule_3) || (rule == 4 && newinfo.support_new_master_rule) || (rule == 5 && newinfo.support_master_rule_2020)) {
            botInfo.push_back(newinfo);
          }
          continue;
        }
      }
      std::fclose(fp);
    }
    lstBotList->clear();
    stBotInfo->setText(L"");
    cbBotDeckCategory->setVisible(false);
    cbBotDeck->setVisible(false);
    for (unsigned int i = 0; i < botInfo.size(); ++i) {
      lstBotList->addItem(botInfo[i].name);
    }
    if (botInfo.empty()) {
      SetStaticText(stBotInfo, 200, guiFont, dataManager.GetSysString(1385));
    }
    else {
      RefreshCategoryDeck(cbBotDeckCategory, cbBotDeck);
    }
  }

  void Game::LoadConfig() {
    FILE *fp = std::fopen("PuzzlePro_system.conf", "r");
    if (!fp) {
      return;
    }
    char linebuf[CONFIG_LINE_SIZE]{};
    char strbuf[64]{};
    char valbuf[960]{};
    while (std::fgets(linebuf, sizeof linebuf, fp)) {
      if (std::sscanf(linebuf, "%63s = %959s", strbuf, valbuf) != 2) {
        continue;
      }
      if (!std::strcmp(strbuf, "antialias")) {
        gameConf.antialias = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "use_d3d")) {
        gameConf.use_d3d = strtol(valbuf, nullptr, 10) > 0;
      }
      else if (!std::strcmp(strbuf, "use_image_scale")) {
        gameConf.use_image_scale = strtol(valbuf, nullptr, 10) > 0;
      }
      else if (!std::strcmp(strbuf, "errorlog")) {
        unsigned int val = strtol(valbuf, nullptr, 10);
        enable_log = val & 0xff;
      }
      //~ else if (! std::strcmp(strbuf, "textfont")) {
      //~ int textfontsize = 0;
      //~ if (std::sscanf(linebuf, "%63s = %959s %d", strbuf, valbuf, &textfontsize) != 3) {
      //~ continue;
      //~ }
      //~ gameConf.textfontsize = textfontsize;
      //~ BufferIO::DecodeUTF8(valbuf, gameConf.textfont);
      //~ }
      //~ else if (! std::strcmp(strbuf, "numfont")) {
      //~ BufferIO::DecodeUTF8(valbuf, gameConf.numfont);
      //~ }
      else if (!std::strcmp(strbuf, "serverport")) {
        gameConf.serverport = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "lasthost")) {
        BufferIO::DecodeUTF8(valbuf, gameConf.lasthost);
      }
      else if (!std::strcmp(strbuf, "lastport")) {
        BufferIO::DecodeUTF8(valbuf, gameConf.lastport);
      }
      else if (!std::strcmp(strbuf, "automonsterpos")) {
        gameConf.chkMAutoPos = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "autospellpos")) {
        gameConf.chkSTAutoPos = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "randompos")) {
        gameConf.chkRandomPos = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "autochain")) {
        gameConf.chkAutoChain = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "waitchain")) {
        gameConf.chkWaitChain = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "showchain")) {
        gameConf.chkDefaultShowChain = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "mute_opponent")) {
        gameConf.chkIgnore1 = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "mute_spectators")) {
        gameConf.chkIgnore2 = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "use_lflist")) {
        gameConf.use_lflist = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "default_lflist")) {
        gameConf.default_lflist = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "default_rule")) {
        gameConf.default_rule = strtol(valbuf, nullptr, 10);
        if (gameConf.default_rule <= 0) {
          gameConf.default_rule = DEFAULT_DUEL_RULE;
        }
      }
      else if (!std::strcmp(strbuf, "hide_setname")) {
        gameConf.hide_setname = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "hide_hint_button")) {
        gameConf.hide_hint_button = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "control_mode")) {
        gameConf.control_mode = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "draw_field_spell")) {
        gameConf.draw_field_spell = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "separate_clear_button")) {
        gameConf.separate_clear_button = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "auto_search_limit")) {
        gameConf.auto_search_limit = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "search_multiple_keywords")) {
        gameConf.search_multiple_keywords = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "ignore_deck_changes")) {
        gameConf.chkIgnoreDeckChanges = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "default_ot")) {
        gameConf.defaultOT = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "enable_bot_mode")) {
        gameConf.enable_bot_mode = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "quick_animation")) {
        gameConf.quick_animation = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "auto_save_replay")) {
        gameConf.auto_save_replay = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "draw_single_chain")) {
        gameConf.draw_single_chain = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "hide_player_name")) {
        gameConf.hide_player_name = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "prefer_expansion_script")) {
        gameConf.prefer_expansion_script = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "window_maximized")) {
        gameConf.window_maximized = strtol(valbuf, nullptr, 10) > 0;
      }
      else if (!std::strcmp(strbuf, "window_width")) {
        gameConf.window_width = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "window_height")) {
        gameConf.window_height = strtol(valbuf, nullptr, 10);
      }
      else if (!std::strcmp(strbuf, "resize_popup_menu")) {
        gameConf.resize_popup_menu = strtol(valbuf, nullptr, 10) > 0;
#if defined(YGOPRO_USE_MINIAUDIO)
      }
      else if (!std::strcmp(strbuf, "enable_sound")) {
        gameConf.enable_sound = strtol(valbuf, nullptr, 10) > 0;
      }
      else if (!std::strcmp(strbuf, "sound_volume")) {
        int vol = strtol(valbuf, nullptr, 10);
        if (vol < 0) {
          vol = 0;
        }
        else if (vol > 100) {
          vol = 100;
        }
        gameConf.sound_volume = (double)vol / 100;
      }
      else if (!std::strcmp(strbuf, "enable_music")) {
        gameConf.enable_music = strtol(valbuf, nullptr, 10) > 0;
      }
      else if (!std::strcmp(strbuf, "music_volume")) {
        int vol = strtol(valbuf, nullptr, 10);
        if (vol < 0) {
          vol = 0;
        }
        else if (vol > 100) {
          vol = 100;
        }
        gameConf.music_volume = (double)vol / 100;
      }
      else if (!std::strcmp(strbuf, "music_mode")) {
        gameConf.music_mode = strtol(valbuf, nullptr, 10);
#endif
      }
      else {
        // options allowing multiple words
        if (std::sscanf(linebuf, "%63s = %959[^\n]", strbuf, valbuf) != 2) {
          continue;
        }
        if (!std::strcmp(strbuf, "textfont")) {
          char *last_space = std::strrchr(valbuf, ' ');
          if (last_space == nullptr) {
            continue;
          }
          int fontsize = std::strtol(last_space + 1, nullptr, 10);
          if (fontsize > 0) {
            gameConf.textfontsize = fontsize;
          }
          *last_space = 0;
          BufferIO::DecodeUTF8(valbuf, gameConf.textfont);
        }
        else if (!std::strcmp(strbuf, "numfont")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.numfont);
        }
        else if (!std::strcmp(strbuf, "nickname")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.nickname);
        }
        else if (!std::strcmp(strbuf, "gamename")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.gamename);
        }
        else if (!std::strcmp(strbuf, "roompass")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.roompass);
        }
        else if (!std::strcmp(strbuf, "lastcategory")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.lastcategory);
        }
        else if (!std::strcmp(strbuf, "lastdeck")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.lastdeck);
        }
        else if (!std::strcmp(strbuf, "bot_deck_path")) {
          BufferIO::DecodeUTF8(valbuf, gameConf.bot_deck_path);
        }
      }
    }
    std::fclose(fp);
  }

  void Game::SaveConfig() {
    FILE *fp = std::fopen("PuzzlePro_system.conf", "w");
    std::fprintf(fp, "#config file\n#nickname & gamename should be less than 20 characters\n");
    char linebuf[CONFIG_LINE_SIZE];
    std::fprintf(fp, "use_d3d = %d\n", gameConf.use_d3d ? 1 : 0);
    std::fprintf(fp, "use_image_scale = %d\n", gameConf.use_image_scale ? 1 : 0);
    std::fprintf(fp, "antialias = %d\n", gameConf.antialias);
    std::fprintf(fp, "errorlog = %u\n", enable_log);
    BufferIO::CopyWideString(ebNickName->getText(), gameConf.nickname);
    BufferIO::EncodeUTF8(gameConf.nickname, linebuf);
    std::fprintf(fp, "nickname = %s\n", linebuf);
    BufferIO::EncodeUTF8(gameConf.gamename, linebuf);
    std::fprintf(fp, "gamename = %s\n", linebuf);
    BufferIO::EncodeUTF8(gameConf.lastcategory, linebuf);
    std::fprintf(fp, "lastcategory = %s\n", linebuf);
    BufferIO::EncodeUTF8(gameConf.lastdeck, linebuf);
    std::fprintf(fp, "lastdeck = %s\n", linebuf);
    BufferIO::EncodeUTF8(gameConf.textfont, linebuf);
    std::fprintf(fp, "textfont = %s %d\n", linebuf, gameConf.textfontsize);
    BufferIO::EncodeUTF8(gameConf.numfont, linebuf);
    std::fprintf(fp, "numfont = %s\n", linebuf);
    std::fprintf(fp, "serverport = %d\n", gameConf.serverport);
    BufferIO::EncodeUTF8(gameConf.lasthost, linebuf);
    std::fprintf(fp, "lasthost = %s\n", linebuf);
    BufferIO::EncodeUTF8(gameConf.lastport, linebuf);
    std::fprintf(fp, "lastport = %s\n", linebuf);
    // settings
    std::fprintf(fp, "automonsterpos = %d\n", (chkMAutoPos->isChecked() ? 1 : 0));
    std::fprintf(fp, "autospellpos = %d\n", (chkSTAutoPos->isChecked() ? 1 : 0));
    std::fprintf(fp, "randompos = %d\n", (chkRandomPos->isChecked() ? 1 : 0));
    std::fprintf(fp, "autochain = %d\n", (chkAutoChain->isChecked() ? 1 : 0));
    std::fprintf(fp, "waitchain = %d\n", (chkWaitChain->isChecked() ? 1 : 0));
    std::fprintf(fp, "showchain = %d\n", (chkDefaultShowChain->isChecked() ? 1 : 0));
    std::fprintf(fp, "mute_opponent = %d\n", (chkIgnore1->isChecked() ? 1 : 0));
    std::fprintf(fp, "mute_spectators = %d\n", (chkIgnore2->isChecked() ? 1 : 0));
    std::fprintf(fp, "use_lflist = %d\n", gameConf.use_lflist);
    std::fprintf(fp, "default_lflist = %d\n", gameConf.default_lflist);
    std::fprintf(fp, "default_rule = %d\n", gameConf.default_rule == DEFAULT_DUEL_RULE ? 0 : gameConf.default_rule);
    std::fprintf(fp, "hide_setname = %d\n", gameConf.hide_setname);
    std::fprintf(fp, "hide_hint_button = %d\n", gameConf.hide_hint_button);
    std::fprintf(fp, "#control_mode = 0: Key A/S/D/R Chain Buttons. control_mode " "= 1: MouseLeft/MouseRight/NULL/F9 Without Chain Buttons\n");
    std::fprintf(fp, "control_mode = %d\n", gameConf.control_mode);
    std::fprintf(fp, "draw_field_spell = %d\n", gameConf.draw_field_spell);
    std::fprintf(fp, "separate_clear_button = %d\n", gameConf.separate_clear_button);
    std::fprintf(fp, "#auto_search_limit >= 0: Start search automatically when " "the user enters N chars\n");
    std::fprintf(fp, "auto_search_limit = %d\n", gameConf.auto_search_limit);
    std::fprintf(fp, "#search_multiple_keywords = 0: Disable. 1: Search mutiple " "keywords with separator \" \". 2: with separator \"+\"\n");
    std::fprintf(fp, "search_multiple_keywords = %d\n", gameConf.search_multiple_keywords);
    std::fprintf(fp, "ignore_deck_changes = %d\n", (chkIgnoreDeckChanges->isChecked() ? 1 : 0));
    std::fprintf(fp, "default_ot = %d\n", gameConf.defaultOT);
    std::fprintf(fp, "enable_bot_mode = %d\n", gameConf.enable_bot_mode);
    BufferIO::EncodeUTF8(gameConf.bot_deck_path, linebuf);
    std::fprintf(fp, "bot_deck_path = %s\n", linebuf);
    std::fprintf(fp, "quick_animation = %d\n", gameConf.quick_animation);
    std::fprintf(fp, "auto_save_replay = %d\n", 0);
    std::fprintf(fp, "draw_single_chain = %d\n", gameConf.draw_single_chain);
    std::fprintf(fp, "hide_player_name = %d\n", gameConf.hide_player_name);
    std::fprintf(fp, "prefer_expansion_script = %d\n", gameConf.prefer_expansion_script);
    std::fprintf(fp, "window_maximized = %d\n", (gameConf.window_maximized ? 1 : 0));
    std::fprintf(fp, "window_width = %d\n", gameConf.window_width);
    std::fprintf(fp, "window_height = %d\n", gameConf.window_height);
    std::fprintf(fp, "resize_popup_menu = %d\n", gameConf.resize_popup_menu ? 1 : 0);
#if defined(YGOPRO_USE_MINIAUDIO)
    std::fprintf(fp, "enable_sound = %d\n", (chkEnableSound->isChecked() ? 1 : 0));
    std::fprintf(fp, "enable_music = %d\n", (chkEnableMusic->isChecked() ? 1 : 0));
    std::fprintf(fp, "#Volume of sound and music, between 0 and 100\n");
    int vol = gameConf.sound_volume * 100;
    std::fprintf(fp, "sound_volume = %d\n", vol);
    vol = gameConf.music_volume * 100;
    std::fprintf(fp, "music_volume = %d\n", vol);
    std::fprintf(fp, "music_mode = %d\n", (chkMusicMode->isChecked() ? 1 : 0));
#endif
    std::fclose(fp);
  }

  //~ int32_t my_count = 0;

  void Game::ShowCardInfo(int code, bool resize) {
    imgCard->setScaleImage(false);
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "xy");
    fast_io::string str;
    if (showingcode == code && !resize) {
      return;
    }
    auto cit = dataManager.GetCodePointer(code);
    bool is_valid = (cit != dataManager.datas_end());
    imgCard->setImage(imageManager.GetBigPicture(code, gui_xy["imgCard"]["width"].cast<double>().value() * xScale, gui_xy["imgCard"]["height"].cast<double>().value() * yScale));
    if (is_valid) {
      const auto &cd = cit->second;
      if (cd.is_alternative()) {
        str.append(fast_io::concat_fast_io(fast_io::mnp::code_cvt_os_c_str(dataManager.GetName(cd.alias)), "[", fast_io::mnp::right(cd.alias, 8, '0'), "]"));
      }
      else {
        str.append(fast_io::concat_fast_io(fast_io::mnp::code_cvt_os_c_str(dataManager.GetName(code)), "[", fast_io::mnp::right(code, 8, '0'), "]"));
      }
    }
    else {
      str.append(fast_io::concat_fast_io(fast_io::mnp::code_cvt_os_c_str(dataManager.GetName(code)), "[", fast_io::mnp::right(code, 8, '0'), "]"));
    }
    currentCardName = str;
    str.append("\n");
    if (is_valid && cit->second.type & TYPE_MONSTER) {
      const auto &cd = cit->second;
      str.append(fast_io::concatln_fast_io("[", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatType(cd.type).c_str()), "] ", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatRace(cd.race).c_str()), "/", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatAttribute(cd.attribute).c_str())));
      //~ const wchar_t* form = L"\u2605";
      fast_io::string form("★");
      //~ form = "★";
      //~ wchar_t adBuffer[64]{};
      fast_io::string ad;
      //~ wchar_t scaleBuffer[16]{};
      if (!(cd.type & TYPE_LINK)) {
        if (cd.type & TYPE_XYZ) {
          //~ form = L"\u2606";
          //~ form = L"☆";
          form.assign("☆");
        }
        if (cd.attack < 0 && cd.defense < 0) {
          //~ myswprintf(adBuffer, L"?/?");
          ad.assign("?/?");
        }
        else if (cd.attack < 0) {
          //~ myswprintf(adBuffer, L"?/%d", cd.defense);
          ad = fast_io::concat_fast_io("?/", cd.defense);
        }
        else if (cd.defense < 0) {
          //~ myswprintf(adBuffer, L"%d/?", cd.attack);
          ad = fast_io::concat_fast_io(cd.attack, "/?");
        }
        else {
          //~ myswprintf(adBuffer, L"%d/%d", cd.attack, cd.defense);

          ad = fast_io::concat_fast_io(cd.attack, "/", cd.defense);
        }
      }
      else {
        form.assign("LINK-");
        if (cd.attack < 0) {
          ad = fast_io::concat_fast_io("?/-   ", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatLinkMarker(cd.link_marker).c_str()));
        }
        else {
          ad = fast_io::concat_fast_io(cd.attack, "/-   ", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatLinkMarker(cd.link_marker).c_str()));
        }
      }
      //~ str.push_back("[");
      str.append(fast_io::concat_fast_io("[", form, cd.level, "]", ad));
      if (cd.type & TYPE_PENDULUM) {
        str.append(fast_io::concat_fast_io("   ", cd.lscale, "/", cd.rscale));
      }
    }
    else {
      if (is_valid) {
        str.append(fast_io::concat_fast_io("[", fast_io::mnp::code_cvt_os_c_str(dataManager.FormatType(cit->second.type).c_str()), "]"));
      }
      else {
        str.append(fast_io::concat_fast_io("[", fast_io::mnp::code_cvt_os_c_str(dataManager.unknown_string), "]"));
      }
    }
    str.append("\n");
    if (is_valid && !gameConf.hide_setname) {
      const auto &cd = cit->second;
      auto target = cit;
      if (cd.alias && dataManager.GetCodePointer(cd.alias) != dataManager.datas_end()) {
        target = dataManager.GetCodePointer(cd.alias);
      }
      if (target->second.setcode[0]) {
        auto setcode_str = fast_io::concat_fast_io(fast_io::mnp::code_cvt_os_c_str(dataManager.GetSysString(1329)), fast_io::mnp::code_cvt_os_c_str(dataManager.FormatSetName(target->second.setcode).c_str()));
        setcode_str.append("\n");
        str.append(setcode_str);
      }
    }
    showingcode = code;
    showingtext = dataManager.GetText(code);

    irr::s32 x;
    irr::s32 y;
    stDataInfo->setText(fast_io::wconcat_fast_io(fast_io::mnp::code_cvt(str.trim_right()), L"\n　").c_str());
    stText->setText(showingtext);
    stDataInfo->setRelativePosition(ResizeWin(gui_xy["stDataInfo"]["x1"], gui_xy["stDataInfo"]["y1"], gui_xy["stDataInfo"]["x2"], gui_xy["stDataInfo"]["y1"].cast<double>().value() + stDataInfo->getTextHeight()));
    stText->setRelativePosition(ResizeWin(gui_xy["stText"]["x1"], gui_xy["stDataInfo"]["y1"].cast<double>().value() + stDataInfo->getTextHeight(), gui_xy["stText"]["x2"], gui_xy["stText"]["y2"]));
    x = stDataInfo->getRelativePosition().UpperLeftCorner.X;
    y = stDataInfo->getRelativePosition().UpperLeftCorner.Y;
    stDataInfo->setRelativePosition(irr::core::rect<irr::s32>(x, y, stDataInfo->getRelativePosition().LowerRightCorner.X, y + stDataInfo->getTextHeight()));
    y = stDataInfo->getRelativePosition().LowerRightCorner.Y;
    stText->setRelativePosition(irr::core::rect<irr::s32>(x, y, stText->getRelativePosition().LowerRightCorner.X, stText->getRelativePosition().LowerRightCorner.Y));
  }

  void Game::ClearCardInfo(int player) {
    imgCard->setScaleImage(true);
    imgCard->setImage(imageManager.tCover[player]);
    showingcode = 0;
    stDataInfo->setText(L"");
    stText->setText(L"");
  }

  void Game::AddLog(const wchar_t *msg, int param) {
    logParam.insert(logParam.begin(), param);
    lstLog->insertItem(0, msg);
    if (!guiEnv->hasFocus(lstLog)) {
      lstLog->setSelected(-1);
    }
  }

  void Game::AddChatMsg(const wchar_t *msg, int player, bool play_sound) {
    for (int i = 7; i > 0; --i) {
      chatMsg[i] = chatMsg[i - 1];
      chatTiming[i] = chatTiming[i - 1];
      chatType[i] = chatType[i - 1];
    }
    chatMsg[0].clear();
    chatTiming[0] = 1200;
    chatType[0] = player;
    if (gameConf.hide_player_name && player < 4) {
      player = 10;
    }
    if (play_sound) {
      soundManager.PlaySoundEffect(SOUND_CHAT);
    }
    switch (player) {
      case 0: // from host
        chatMsg[0].append(dInfo.hostname);
        chatMsg[0].append(L": ");
        break;
      case 1: // from client
        chatMsg[0].append(dInfo.clientname);
        chatMsg[0].append(L": ");
        break;
      case 2: // host tag
        chatMsg[0].append(dInfo.hostname_tag);
        chatMsg[0].append(L": ");
        break;
      case 3: // client tag
        chatMsg[0].append(dInfo.clientname_tag);
        chatMsg[0].append(L": ");
        break;
      case 7: // local name
        chatMsg[0].append(ebNickName->getText());
        chatMsg[0].append(L": ");
        break;
      case 8: // system custom message, no prefix.
        chatMsg[0].append(L"[System]: ");
        break;
      case 9: // error message
        chatMsg[0].append(L"[Script Error]: ");
        break;
      case 10: // hidden name
        chatMsg[0].append(L"[********]: ");
        break;
      default: // from watcher or unknown
        if (player < 11 || player > 19) {
          chatMsg[0].append(L"[---]: ");
        }
    }
    chatMsg[0].append(msg);
  }

  void Game::ClearChatMsg() {
    for (int i = 7; i >= 0; --i) {
      chatTiming[i] = 0;
    }
  }

  void Game::AddDebugMsg(const char *msg) {
    if (enable_log & 0x1) {
      wchar_t wbuf[1024];
      BufferIO::DecodeUTF8(msg, wbuf);
      AddChatMsg(wbuf, 9);
    }
    if (enable_log & 0x2) {
      char msgbuf[1040];
      std::snprintf(msgbuf, sizeof msgbuf, "[Script Error]: %s", msg);
      ErrorLog(msgbuf);
    }
  }

  void Game::ErrorLog(const char *msg) {
    FILE *fp = std::fopen("error.log", "a");
    if (!fp) {
      return;
    }
    time_t nowtime = std::time(nullptr);
    char timebuf[40];
    std::strftime(timebuf, sizeof timebuf, "%Y-%m-%d %H:%M:%S", std::localtime(&nowtime));
    std::fprintf(fp, "[%s]%s\n", timebuf, msg);
    std::fclose(fp);
  }

  void Game::ClearTextures() {
    matManager.mCard.setTexture(0, nullptr);
    ClearCardInfo(0);
    btnPSAU->setImage();
    btnPSDU->setImage();
    for (int i = 0; i <= 4; ++i) {
      btnCardSelect[i]->setImage();
      btnCardDisplay[i]->setImage();
    }
    imageManager.ClearTexture();
  }

  void Game::CloseGameButtons() {
    btnChainIgnore->setVisible(false);
    btnChainAlways->setVisible(false);
    btnChainWhenAvail->setVisible(false);
    btnCancelOrFinish->setVisible(false);
    btnSpectatorSwap->setVisible(false);
    btnShuffle->setVisible(false);
    wSurrender->setVisible(false);
    chain_timing_combo_box->setVisible(false);
  }

  void Game::CloseGameWindow() {
    CloseGameButtons();
    for (auto wit = fadingList.begin(); wit != fadingList.end(); ++wit) {
      if (wit->isFadein) {
        wit->autoFadeoutFrame = 1;
      }
    }
    wACMessage->setVisible(false);
    wANAttribute->setVisible(false);
    wANCard->setVisible(false);
    wANNumber->setVisible(false);
    wANRace->setVisible(false);
    wCardSelect->setVisible(false);
    wCardDisplay->setVisible(false);
    //~ wCmdMenu->setVisible(false);
    wFTSelect->setVisible(false);
    wHand->setVisible(false);
    wMessage->setVisible(false);
    smMessage->setVisible(false);
    wOptions->setVisible(false);
    wPhase->setVisible(false);
    wPosSelect->setVisible(false);
    wQuery->setVisible(false);
    wReplayControl->setVisible(false);
    wReplaySave->setVisible(false);
    stHintMsg->setVisible(false);
    stTip->setVisible(false);
  }

  void Game::CloseDuelWindow() {
    CloseGameWindow();
    wCardImg->setVisible(false);
    wInfos->setVisible(false);
    wChat->setVisible(false);
    btnSideOK->setVisible(false);
    btnSideShuffle->setVisible(false);
    btnSideSort->setVisible(false);
    btnSideReload->setVisible(false);
    btnLeaveGame->setVisible(false);
    btnSpectatorSwap->setVisible(false);
    lstLog->clear();
    logParam.clear();
    lstHostList->clear();
    DuelClient::hosts.clear();
    ClearTextures();
    ResizeChatInputWindow();
    closeDoneSignal.Set();
  }

  int Game::LocalPlayer(int player) const {
    int pid = player ? 1 : 0;
    return dInfo.isFirst ? pid : 1 - pid;
  }

  int Game::OppositePlayer(int player) {
    auto player_side_bit = dInfo.isTag ? 0x2 : 0x1;
    return player ^ player_side_bit;
  }

  int Game::ChatLocalPlayer(int player) {
    if (player > 3) {
      return player;
    }
    bool is_self = false;
    if (dInfo.isStarted || is_siding) {
      if (dInfo.isInDuel) {
        // when in duel
        player = mainGame->dInfo.isFirst ? player : OppositePlayer(player);
      }
      else {
        // when changing side or waiting tp result
        auto selftype_boundary = dInfo.isTag ? 2 : 1;
        if (DuelClient::selftype >= selftype_boundary && DuelClient::selftype < 4) {
          player = OppositePlayer(player);
        }
      }
      if (DuelClient::selftype >= 4) {
        is_self = false;
      }
      else if (dInfo.isTag) {
        is_self = (player & 0x2) == 0 && (player & 0x1) == (DuelClient::selftype & 0x1);
      }
      else {
        is_self = player == 0;
      }
    }
    else {
      // when in lobby
      is_self = player == DuelClient::selftype;
    }
    if (dInfo.isTag && (player == 1 || player == 2)) {
      player = 3 - player;
    }
    return player | (is_self ? 0x10 : 0);
  }

  const wchar_t *Game::LocalName(int local_player) {
    return local_player == 0 ? dInfo.hostname : dInfo.clientname;
  }

  void Game::recursive_scale_element(irr::gui::IGUIElement *element, std::unordered_map<irr::gui::IGUIElement *, irr::core::rect<irr::s32>> &origin_rects) {
    if (!element) {
      return;
    }
    if (!origin_rects.contains(element)) {
      origin_rects[element] = element->getRelativePosition();
    }
    const irr::core::rect<irr::s32> &origin = origin_rects[element];
    //~ auto rp = element->getRelativePosition();
    if (!no_scale_elements.contains(element)) {
      //~ element->setRelativePosition(ResizeWin(origin.UpperLeftCorner.X, origin.UpperLeftCorner.Y, origin.LowerRightCorner.X, origin.LowerRightCorner.Y));
      //~ auto rp1 = InverseResizeWin(rp.UpperLeftCorner.X, rp.UpperLeftCorner.Y, rp.LowerRightCorner.X, rp.LowerRightCorner.Y);
      element->setRelativePosition(ResizeWin(origin.UpperLeftCorner.X, origin.UpperLeftCorner.Y, origin.LowerRightCorner.X, origin.LowerRightCorner.Y));
    }
    //~ fast_io::perrln(fast_io::mnp::os_c_str(element->getName()));
    for (auto it = element->getChildren().begin(); it != element->getChildren().end(); ++it) {
      recursive_scale_element(*it, origin_rects);
    }
  }

  void Game::scale_whole_gui(irr::gui::IGUIEnvironment *gui_environment) {
    static std::unordered_map<irr::gui::IGUIElement *, irr::core::rect<irr::s32>> origin_rects;
    recursive_scale_element(gui_environment->getRootGUIElement(), origin_rects);
  }

  void Game::resize_element_int(irr::gui::IGUIElement *o1, const char *o2) {
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "xy");
    o1->setRelativePosition(ResizeWin(gui_xy[o2]["x1"], gui_xy[o2]["y1"], gui_xy[o2]["x2"], gui_xy[o2]["y2"]));
  }

  void Game::resize_font() {
    using boost::this_thread::get_id;
    using irr::gui::CGUITTFont;
    using luabridge::getGlobal;
    using luabridge::main_thread;

    auto gui_config = getGlobal(main_thread(this->get_lua(get_id())), "config");

    CGUITTFont *old_numFont = numFont;
    CGUITTFont *old_adFont = adFont;
    CGUITTFont *old_lpcFont = lpcFont;
    numFont = CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 16 * yScale, true, true, gui_config["font_outline_width"]);
    adFont = CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 12 * yScale, true, true, gui_config["font_outline_width"]);
    lpcFont = CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.numfont, 48 * yScale, true, true, gui_config["font_outline_width"]);
    numFont->setFontHinting(true, false);
    adFont->setFontHinting(true, false);
    lpcFont->setFontHinting(true, false);
    int64_t font_outline_width = gui_config["font_outline_color"];
    numFont->setOutlineColor(font_outline_width);
    adFont->setOutlineColor(font_outline_width);
    lpcFont->setOutlineColor(font_outline_width);
    old_numFont->drop();
    old_adFont->drop();
    old_lpcFont->drop();

    CGUITTFont *old_guiFont = guiFont;
    CGUITTFont *old_textFont = textFont;
    guiFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    textFont = irr::gui::CGUITTFont::createTTFont(driver, DataManager::FileSystem, gameConf.textfont, gameConf.textfontsize, true, true);
    guiFont->setFontHinting(true, false);
    textFont->setFontHinting(true, false);
    old_guiFont->drop();
    old_textFont->drop();
    guiEnv->getSkin()->setFont(guiFont);
  }

  void Game::OnResize() {
    this->replace_new_lua_sup1();
    auto gui_xy = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "xy");
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "config");

    WINDOWPLACEMENT plc;
    plc.length = sizeof(WINDOWPLACEMENT);
    if (GetWindowPlacement(hWnd, &plc)) {
      gameConf.window_maximized = (plc.showCmd == SW_SHOWMAXIMIZED);
    }
    if (!gameConf.window_maximized) {
      gameConf.window_width = window_size.Width;
      gameConf.window_height = window_size.Height;
    }

    resize_font();
    resize_skin();

    imageManager.ClearTexture();
    imageManager.ResizeTexture();

    //~ wDeckEdit->setRelativePosition(Resize(309, 5, 605, 130));
    //~ cbDBDecks->setRelativePosition(Resize(80, 35, 220, 60));
    //~ btnClearDeck->setRelativePosition(Resize(115, 99, 165, 120));
    //~ btnSortDeck->setRelativePosition(Resize(60, 99, 110, 120));
    //~ btnShuffleDeck->setRelativePosition(Resize(5, 99, 55, 120));
    //~ btnSaveDeck->setRelativePosition(Resize(225, 35, 290, 60));
    //~ btnSaveDeckAs->setRelativePosition(Resize(225, 65, 290, 90));
    //~ ebDeckname->setRelativePosition(Resize(80, 65, 220, 90));
    //~ cbDBCategory->setRelativePosition(Resize(80, 5, 220, 30));
    //~ btnManageDeck->setRelativePosition(Resize(225, 5, 290, 30));
    //~ wDeckManage->setRelativePosition(ResizeWin(310, 135, 800, 465));
    //~ scrPackCards->setRelativePosition(Resize(775, 161, 795, 629));

    //~ wSort->setRelativePosition(Resize(930, 132, 1020, 156));
    //~ cbSortType->setRelativePosition(Resize(10, 2, 85, 22));
    //~ wFilter->setRelativePosition(Resize(610, 5, 1020, 130));
    //~ scrFilter->setRelativePosition(Resize(999, 161, 1019, 629));
    //~ cbCardType->setRelativePosition(Resize(60, 25 / 6, 120, 20 + 25 / 6));
    //~ cbCardType2->setRelativePosition(Resize(125, 25 / 6, 195, 20 + 25 / 6));
    //~ cbRace->setRelativePosition(Resize(60, 40 + 75 / 6, 195, 60 + 75 / 6));
    //~ cbAttribute->setRelativePosition(Resize(60, 20 + 50 / 6, 195, 40 + 50 / 6));
    //~ cbLimit->setRelativePosition(Resize(260, 25 / 6, 390, 20 + 25 / 6));
    //~ ebStar->setRelativePosition(Resize(60, 60 + 100 / 6, 95, 80 + 100 / 6));
    //~ ebScale->setRelativePosition(Resize(155, 60 + 100 / 6, 195, 80 + 100 / 6));
    //~ ebAttack->setRelativePosition(Resize(260, 20 + 50 / 6, 340, 40 + 50 / 6));
    //~ ebDefense->setRelativePosition(Resize(260, 40 + 75 / 6, 340, 60 + 75 / 6));
    //~ ebCardName->setRelativePosition(Resize(260, 60 + 100 / 6, 390, 80 + 100 / 6));
    //~ btnEffectFilter->setRelativePosition(Resize(345, 20 + 50 / 6, 390, 60 + 75 / 6));
    //~ btnStartFilter->setRelativePosition(Resize(260, 80 + 125 / 6, 390, 100 + 125 / 6));
    //~ if (btnClearFilter) {
    //~ btnClearFilter->setRelativePosition(Resize(205, 80 + 125 / 6, 255, 100 + 125 / 6));
    //~ }
    //~ btnMarksFilter->setRelativePosition(Resize(60, 80 + 125 / 6, 195, 100 + 125 / 6));

    //~ irr::core::recti btncatepos = btnEffectFilter->getAbsolutePosition();
    //~ wCategories->setRelativePosition(irr::core::recti(btncatepos.LowerRightCorner.X - wCategories->getRelativePosition().getWidth(), btncatepos.LowerRightCorner.Y - btncatepos.getHeight() / 2, btncatepos.LowerRightCorner.X, btncatepos.LowerRightCorner.Y - btncatepos.getHeight() / 2 + 245));

    //~ wLinkMarks->setRelativePosition(ResizeWin(700, 30, 820, 150));
    //~ stDBCategory->setRelativePosition(Resize(10, 9, 100, 29));
    //~ stDeck->setRelativePosition(Resize(10, 39, 100, 59));
    //~ stCategory->setRelativePosition(Resize(10, 2 + 25 / 6, 70, 22 + 25 / 6));
    //~ stLimit->setRelativePosition(Resize(205, 2 + 25 / 6, 280, 22 + 25 / 6));
    //~ stAttribute->setRelativePosition(Resize(10, 22 + 50 / 6, 70, 42 + 50 / 6));
    //~ stRace->setRelativePosition(Resize(10, 42 + 75 / 6, 70, 62 + 75 / 6));
    //~ stAttack->setRelativePosition(Resize(205, 22 + 50 / 6, 280, 42 + 50 / 6));
    //~ stDefense->setRelativePosition(Resize(205, 42 + 75 / 6, 280, 62 + 75 / 6));
    //~ stStar->setRelativePosition(Resize(10, 62 + 100 / 6, 70, 82 + 100 / 6));
    //~ stSearch->setRelativePosition(Resize(205, 62 + 100 / 6, 280, 82 + 100 / 6));
    //~ stScale->setRelativePosition(Resize(105, 62 + 100 / 6, 165, 82 + 100 / 6));
    //~ btnSideOK->setRelativePosition(Resize(400, 40, 710, 80));
    //~ btnSideShuffle->setRelativePosition(Resize(310, 100, 370, 130));
    //~ btnSideSort->setRelativePosition(Resize(375, 100, 435, 130));
    //~ btnSideReload->setRelativePosition(Resize(440, 100, 500, 130));
    //~ btnDeleteDeck->setRelativePosition(Resize(225, 95, 290, 120));

    //~ wLanWindow->setRelativePosition(ResizeWin(220, 100, 800, 520));
    //~ wCreateHost->setRelativePosition(ResizeWin(320, 100, 700, 520));
    //~ wHostPrepare->setRelativePosition(ResizeWin(270, 120, 750, 440));
    //~ wReplay->setRelativePosition(ResizeWin(220, 100, 800, 520));

    //~ wHand->setRelativePosition(ResizeWin(500, 450, 825, 605));
    //~ wFTSelect->setRelativePosition(ResizeWin(550, 240, 780, 340));
    //~ wMessage->setRelativePosition(ResizeWin(490, 200, 840, 340));
    //~ wACMessage->setRelativePosition(ResizeWin(490, 240, 840, 300));
    //~ wQuery->setRelativePosition(ResizeWin(490, 200, 840, 340));
    //~ wSurrender->setRelativePosition(ResizeWin(490, 200, 840, 340));
    //~ wOptions->setRelativePosition(ResizeWin(490, 200, 840, 340));
    //~ wPosSelect->setRelativePosition(ResizeWin(340, 200, 935, 410));
    //~ wCardSelect->setRelativePosition(ResizeWin(320, 100, 1000, 400));
    //~ wANNumber->setRelativePosition(ResizeWin(550, 180, 780, 430));
    //~ wANCard->setRelativePosition(ResizeWin(510, 120, 820, 420));
    //~ wANAttribute->setRelativePosition(ResizeWin(500, 200, 830, 285));
    //~ wANRace->setRelativePosition(ResizeWin(480, 200, 850, 410));
    //~ wReplaySave->setRelativePosition(ResizeWin(510, 200, 820, 320));
    //~ wDMQuery->setRelativePosition(ResizeWin(400, 200, 710, 320));

    //~ stHintMsg->setRelativePosition(ResizeWin(660 - 160 * xScale, 60, 660 + 160 * xScale, 90));

    // sound / music volume bar
    //~ scrSoundVolume->setRelativePosition(irr::core::recti(scrSoundVolume->getRelativePosition().UpperLeftCorner.X, scrSoundVolume->getRelativePosition().UpperLeftCorner.Y, 20 + (300 * xScale) - 70, scrSoundVolume->getRelativePosition().LowerRightCorner.Y));
    //~ scrMusicVolume->setRelativePosition(irr::core::recti(scrMusicVolume->getRelativePosition().UpperLeftCorner.X, scrMusicVolume->getRelativePosition().UpperLeftCorner.Y, 20 + (300 * xScale) - 70, scrMusicVolume->getRelativePosition().LowerRightCorner.Y));

    //~ irr::core::recti tabHelperPos = irr::core::recti(0, 0, 300 * xScale - 50, 365 * yScale - 65);
    //~ tabHelper->setRelativePosition(tabHelperPos);
    //~ scrTabHelper->setRelativePosition(irr::core::recti(tabHelperPos.LowerRightCorner.X + 2, 0, tabHelperPos.LowerRightCorner.X + 22, tabHelperPos.LowerRightCorner.Y));
    //~ irr::s32 tabHelperLastY = elmTabHelperLast->getRelativePosition().LowerRightCorner.Y;
    //~ if (tabHelperLastY > tabHelperPos.LowerRightCorner.Y) {
    //~ scrTabHelper->setMax(tabHelperLastY - tabHelperPos.LowerRightCorner.Y + 5);
    //~ scrTabHelper->setPos(0);
    //~ scrTabHelper->setVisible(true);
    //~ }
    //~ else {
    //~ scrTabHelper->setVisible(false);
    //~ }

    //~ irr::core::recti tabSystemPos = irr::core::recti(0, 0, 300 * xScale - 50, 365 * yScale - 65);
    //~ tabSystem->setRelativePosition(tabSystemPos);
    //~ scrTabSystem->setRelativePosition(irr::core::recti(tabSystemPos.LowerRightCorner.X + 2, 0, tabSystemPos.LowerRightCorner.X + 22, tabSystemPos.LowerRightCorner.Y));
    //~ irr::s32 tabSystemLastY = elmTabSystemLast->getRelativePosition().LowerRightCorner.Y;
    //~ if (tabSystemLastY > tabSystemPos.LowerRightCorner.Y) {
    //~ scrTabSystem->setMax(tabSystemLastY - tabSystemPos.LowerRightCorner.Y + 5);
    //~ scrTabSystem->setPos(0);
    //~ scrTabSystem->setVisible(true);
    //~ }
    //~ else {
    //~ scrTabSystem->setVisible(false);
    //~ }

    //~ lstLog->setRelativePosition(Resize(10, 10, 290, 290));
    //~ if (showingcode) {
    //~ ShowCardInfo(showingcode, true);
    //~ }
    //~ else {
    //~ ClearCardInfo();
    //~ }
    //~ btnClearLog->setRelativePosition(Resize(160, 300, 260, 325));

    //~ wPhase->setRelativePosition(Resize(480, 310, 855, 330));
    //~ btnPhaseStatus->setRelativePosition(Resize(0, 0, 50, 20));
    //~ btnBP->setRelativePosition(Resize(160, 0, 210, 20));
    //~ btnM2->setRelativePosition(Resize(160, 0, 210, 20));
    //~ btnEP->setRelativePosition(Resize(320, 0, 370, 20));

    //~ ResizeChatInputWindow();

    //~ btnLeaveGame->setRelativePosition(Resize(205, 5, 295, 80));
    //~ wReplayControl->setRelativePosition(Resize(205, 143, 295, 273));
    //~ btnReplayStart->setRelativePosition(Resize(5, 5, 85, 25));
    //~ btnReplayPause->setRelativePosition(Resize(5, 5, 85, 25));
    //~ btnReplayStep->setRelativePosition(Resize(5, 55, 85, 75));
    //~ btnReplayUndo->setRelativePosition(Resize(5, 80, 85, 100));
    //~ btnReplaySwap->setRelativePosition(Resize(5, 30, 85, 50));
    //~ btnReplayExit->setRelativePosition(Resize(5, 105, 85, 125));

    //~ btnSpectatorSwap->setRelativePosition(Resize(205, 100, 295, 135));
    //~ btnChainAlways->setRelativePosition(Resize(205, 140, 295, 175));
    //~ btnChainIgnore->setRelativePosition(Resize(205, 100, 295, 135));
    //~ btnChainWhenAvail->setRelativePosition(Resize(205, 180, 295, 215));
    //~ btnShuffle->setRelativePosition(Resize(205, 230, 295, 265));
    //~ btnCancelOrFinish->setRelativePosition(Resize(205, 230, 295, 265));

    //~ btnBigCardOriginalSize->setRelativePosition(Resize(205, 100, 295, 135));
    //~ btnBigCardZoomIn->setRelativePosition(Resize(205, 140, 295, 175));
    //~ btnBigCardZoomOut->setRelativePosition(Resize(205, 180, 295, 215));
    //~ btnBigCardClose->setRelativePosition(Resize(205, 230, 295, 265));

    //~ for (int i = 0; i < 5; ++i) {
    //~ stCardPos[i]->setRelativePosition(ResizeWin(gui_xy["stCardPos"]["x1"].cast<int32_t>().value() + gui_xy["stCardPos"]["width_offset"].cast<int32_t>().value() * i, gui_xy["stCardPos"]["y1"], gui_xy["stCardPos"]["x2"].cast<int32_t>().value() + gui_xy["stCardPos"]["width_offset"].cast<int32_t>().value() * i, gui_xy["stCardPos"]["y2"]));
    //~ btnCardSelect[i]->setRelativePosition(ResizeWin(gui_xy["btnCardSelect"]["x1"].cast<double>().value() + gui_xy["btnCardSelect"]["width_offset"].cast<double>().value() * i, gui_xy["btnCardSelect"]["y1"], gui_xy["btnCardSelect"]["x2"].cast<double>().value() + gui_xy["btnCardSelect"]["width_offset"].cast<double>().value() * i, gui_xy["btnCardSelect"]["y2"]));
    //~ btnCardSelect[i]->setImageSize(irr::core::dimension2di(gui_xy["btnCardSelect"]["width_reduce"].cast<double>().value() * xScale, gui_xy["btnCardSelect"]["height_reduce"].cast<double>().value() * yScale));
    //~ btnCardSelect[i]->setImageSize(irr::core::dimension2di(btnCardSelect[i]->getRelativePosition().getWidth() * xScale, btnCardSelect[i]->getRelativePosition().getHeight() * yScale));
    //~ btnCardSelect[i]->draw();
    //~ }
    //~ for (int filter = 0x1, i = 0; i < RACES_COUNT; filter <<= 1, ++i) {
    //~ chkRace[i]->setRelativePosition(ResizeWin(gui_xy["chkRace"]["x1"].cast<double>().value() + (i % 4) * (gui_xy["chkRace"]["x2"].cast<double>().value() - gui_xy["chkRace"]["x1"].cast<double>().value()), gui_xy["chkRace"]["y1"].cast<double>().value() + (i / 4) * (gui_xy["chkRace"]["y2"].cast<double>().value() - gui_xy["chkRace"]["y1"].cast<double>().value()), gui_xy["chkRace"]["x2"].cast<double>().value() + (i % 4) * (gui_xy["chkRace"]["x2"].cast<double>().value() - gui_xy["chkRace"]["x1"].cast<double>().value()), gui_xy["chkRace"]["y2"].cast<double>().value() + (i / 4) * (gui_xy["chkRace"]["y2"].cast<double>().value() -
    // gui_xy["chkRace"]["y1"].cast<double>().value())));
    //~ }

    //~ guiEnv->getSkin()->setSize(irr::gui::EGDS_SCROLLBAR_SIZE, static_cast<irr::s32>(gui_config["scrollbar_witdh"].cast<irr::f32>().valueOr(15) * xScale));
    //~ guiEnv->getSkin()->setSize(irr::gui::EGDS_WINDOW_BUTTON_WIDTH, static_cast<irr::s32>(15 * xScale));

    //~ resize_element(wMainMenu, "wMainMenu");
    //~ resize_element(btnLanMode, "btnLanMode");
    //~ resize_element(btnSingleMode, "btnSingleMode");
    //~ resize_element(btnReplayMode, "btnReplayMode");
    //~ resize_element(btnDeckEdit, "btnDeckEdit");
    //~ resize_element(btnModeExit, "btnModeExit");

    //~ resize_element(wReplay, "wReplay");
    //~ resize_element(lstReplayList, "lstReplayList");
    //~ resize_element(stReplayTip, "stReplayTip");
    //~ resize_element(stReplayInfo, "stReplayInfo");
    //~ resize_element(replay_file_select_panel, "replay_file_select_panel");
    //~ resize_element(replay_panel, "replay_panel");
    //~ resize_element(stReplayTurnTip, "stReplayTurnTip");
    //~ resize_element(ebRepStartTurn, "ebRepStartTurn");
    //~ resize_element(btnLoadReplay, "btnLoadReplay");
    //~ resize_element(btnReplayCancel, "btnReplayCancel");
    //~ resize_element(btnExportDeck, "btnExportDeck");
    //~ resize_element(btnDeleteReplay, "btnDeleteReplay");
    //~ resize_element(btnRenameReplay, "btnRenameReplay");
    //~ resize_element(check_single_replay_button, "check_single_replay_button");
    //~ resize_element(check_single_layer_replay_button, "check_single_layer_replay_button");
    //~ resize_element(check_multi_layer_replay_button, "check_multi_layer_replay_button");

    //~ resize_element(check_replay_window, "check_replay_window");
    //~ resize_element(check_replay_table, "check_replay_table");

    //~ resize_element(wCardImg, "wCardImg");
    //~ resize_element(imgCard, "imgCard");

    //~ resize_element(wInfos, "wInfos");
    //~ resize_element(stDataInfo, "stDataInfo");
    //~ resize_element(stText, "stText");
    //~ resize_element(lstLog, "lstLog");
    //~ resize_element(btnClearLog, "btnClearLog");
    //~ resize_element(system_setting_tab, "system_setting_tab");

    //~ resize_element($a.3, "$a.3");
    //~ cc.p

    //~ for (int64_t i = 0, n = should_resize_element_vector.size(); i != n; ++i) {

    //~ for (int64_t i = 0; i < btnOption_count; ++i) {
    //~ should_resize_element_unordered_map_int.insert_or_assign(btnOption[i], "btnOption");
    //~ auto gui_xy = luabridge::getGlobal(luabridge::main_thread(mainGame->gui_xy_4), "xy");
    //~ int64_t btnOption_y1 = gui_xy["btnOption"]["y1"];
    //~ int64_t btnOption_y2 = gui_xy["btnOption"]["y2"];
    //~ int64_t btnOption_height_offset = gui_xy["btnOption"]["height_offset"];
    //~ btnOption[i]->setRelativePosition(ResizeWin(gui_xy["btnOption"]["x1"], btnOption_y1 + btnOption_height_offset * i, gui_xy["btnOption"]["x2"], btnOption_y2 + btnOption_height_offset * i));
    //~ }

    for (int64_t filter = 0x1, i = 0; i < 7; filter <<= 1, ++i) {
      int64_t gui_xy_chkAttribute_x1 = gui_xy["chkAttribute"]["x1"];
      int64_t gui_xy_chkAttribute_y1 = gui_xy["chkAttribute"]["y1"];
      int64_t gui_xy_chkAttribute_x2 = gui_xy["chkAttribute"]["x2"];
      int64_t gui_xy_chkAttribute_y2 = gui_xy["chkAttribute"]["y2"];
      int64_t gui_xy_chkAttribute_width_offset = gui_xy["chkAttribute"]["width_offset"];
      int64_t gui_xy_chkAttribute_height_offset = gui_xy["chkAttribute"]["height_offset"];
      chkAttribute[i]->setRelativePosition(ResizeWin(gui_xy_chkAttribute_x1 + (i % 4) * gui_xy_chkAttribute_width_offset, gui_xy_chkAttribute_y1 + (i / 4) * gui_xy_chkAttribute_height_offset, gui_xy_chkAttribute_x2 + (i % 4) * gui_xy_chkAttribute_width_offset, gui_xy_chkAttribute_y2 + (i / 4) * gui_xy_chkAttribute_height_offset));
    }

    for (const auto &i : should_resize_element_unordered_map_int) {
      resize_element_int(i.first, i.second);
    }
    //~ for (const auto &i : should_resize_element_unordered_map_float) {
    //~ resize_element_float(i.first, i.second);
    //~ }

    //~ double check_replay_table_column_width_1 = gui_config["check_replay_table_column_width"][1];
    //~ double check_replay_table_column_width_2 = gui_config["check_replay_table_column_width"][2];
    //~ double check_replay_table_column_width_3 = gui_config["check_replay_table_column_width"][3];

    //~ check_replay_table->setColumnWidth(0, check_replay_table_column_width_1 * xScale);
    //~ check_replay_table->setColumnWidth(1, check_replay_table_column_width_2 * xScale);
    //~ check_replay_table->setColumnWidth(2, check_replay_table_column_width_3 * xScale);

    resize_item_height();
    //~ scale_whole_gui(guiEnv);
    if (showingcode) {
      ShowCardInfo(showingcode, true);
    }
    else {
      ClearCardInfo();
    }
  }

  void Game::resize_item_height() {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(this->get_lua(boost::this_thread::get_id())), "config");

    int64_t item_height = gui_config["item_height"].cast<double>().value() * yScale;
    lstHostList->setItemHeight(item_height);
    lstLog->setItemHeight(item_height);
    //~ lstReplayList->setItemHeight(item_height);
    lstBotList->setItemHeight(item_height);
    single_file_select_panel->setItemHeight(item_height);
    replay_file_select_panel->setItemHeight(item_height);
  }

  void Game::ResizeChatInputWindow() {
    irr::s32 x = wInfos->getRelativePosition().LowerRightCorner.X + 6;
    if (is_building) {
      x = 802 * xScale;
    }
    wChat->setRelativePosition(irr::core::recti(x, window_size.Height - 25, window_size.Width, window_size.Height));
    ebChatInput->setRelativePosition(irr::core::recti(3, 2, window_size.Width - wChat->getRelativePosition().UpperLeftCorner.X - 6, 22));
  }

  irr::core::recti Game::Resize(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
    x = x * xScale;
    y = y * yScale;
    x2 = x2 * xScale;
    y2 = y2 * yScale;
    return irr::core::recti(x, y, x2, y2);
  }

  irr::core::recti Game::Resize(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2, irr::s32 dx, irr::s32 dy, irr::s32 dx2, irr::s32 dy2) {
    x = x * xScale + dx;
    y = y * yScale + dy;
    x2 = x2 * xScale + dx2;
    y2 = y2 * yScale + dy2;
    return irr::core::recti(x, y, x2, y2);
  }

  irr::core::vector2di Game::Resize(irr::s32 x, irr::s32 y) {
    x = x * xScale;
    y = y * yScale;
    return irr::core::vector2di(x, y);
  }

  irr::core::vector2di Game::ResizeReverse(irr::s32 x, irr::s32 y) {
    x = x / xScale;
    y = y / yScale;
    return irr::core::vector2di(x, y);
  }

  irr::core::recti Game::ResizeWin(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
    irr::s32 w = x2 - x;
    irr::s32 h = y2 - y;
    irr::s32 w1 = w * xScale;
    irr::s32 h1 = h * yScale;
    x = (x + w / 2) * xScale - w1 / 2;
    y = (y + h / 2) * yScale - h1 / 2;
    x2 = w1 + x;
    y2 = h1 + y;
    return irr::core::recti(x, y, x2, y2);
  }

  //~ irr::core::recti Game::InverseResizeWin(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
  //~ // 计算缩放后的宽度和高度
  //~ irr::s32 w1 = x2 - x;
  //~ irr::s32 h1 = y2 - y;

  //~ // 计算原始宽度和高度
  //~ irr::s32 w = static_cast<irr::s32>(w1 / last_x_scale);
  //~ irr::s32 h = static_cast<irr::s32>(h1 / last_y_scale);

  //~ // 反推原始坐标
  //~ irr::s32 original_x = static_cast<irr::s32>((x + w1 / 2) / last_x_scale - w / 2);
  //~ irr::s32 original_y = static_cast<irr::s32>((y + h1 / 2) / last_y_scale - h / 2);

  //~ // 计算原始右下角坐标
  //~ irr::s32 original_x2 = original_x + w;
  //~ irr::s32 original_y2 = original_y + h;

  //~ return irr::core::recti(original_x, original_y, original_x2, original_y2);
  //~ }

  //~ irr::core::recti Game::InverseResizeWin(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
  //~ // 使用浮点数计算以避免整数除法误差
  //~ irr::f32 fx = static_cast<irr::f32>(x);
  //~ irr::f32 fy = static_cast<irr::f32>(y);
  //~ irr::f32 fx2 = static_cast<irr::f32>(x2);
  //~ irr::f32 fy2 = static_cast<irr::f32>(y2);

  //~ // 计算缩放后的宽度和高度（浮点数）
  //~ irr::f32 fw1 = fx2 - fx;
  //~ irr::f32 fh1 = fy2 - fy;

  //~ // 计算原始宽度和高度（除以缩放因子）
  //~ irr::f32 fw = fw1 / last_x_scale;
  //~ irr::f32 fh = fh1 / last_y_scale;

  //~ // 反推原始坐标（浮点数计算）
  //~ irr::f32 foriginal_x = (fx + fw1 * 0.5f) / last_x_scale - fw * 0.5f;
  //~ irr::f32 foriginal_y = (fy + fh1 * 0.5f) / last_y_scale - fh * 0.5f;

  //~ // 计算原始右下角坐标（浮点数）
  //~ irr::f32 foriginal_x2 = foriginal_x + fw;
  //~ irr::f32 foriginal_y2 = foriginal_y + fh;

  //~ // 四舍五入到整数（减少误差）
  //~ irr::s32 original_x = static_cast<irr::s32>(foriginal_x + 0.5f);
  //~ irr::s32 original_y = static_cast<irr::s32>(foriginal_y + 0.5f);
  //~ irr::s32 original_x2 = static_cast<irr::s32>(foriginal_x2 + 0.5f);
  //~ irr::s32 original_y2 = static_cast<irr::s32>(foriginal_y2 + 0.5f);

  //~ return irr::core::recti(original_x, original_y, original_x2, original_y2);
  //~ }

  irr::core::recti Game::ResizePhaseHint(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2, irr::s32 width) {
    x = x * xScale - width / 2;
    y = y * yScale;
    x2 = x2 * xScale;
    y2 = y2 * yScale;
    return irr::core::recti(x, y, x2, y2);
  }

  irr::core::recti Game::ResizeCardImgWin(irr::s32 x, irr::s32 y, irr::s32 mx, irr::s32 my) {
    float mul = xScale;
    if (xScale > yScale) {
      mul = yScale;
    }
    irr::s32 w = CARD_IMG_WIDTH * mul + mx * xScale;
    irr::s32 h = CARD_IMG_HEIGHT * mul + my * yScale;
    x = x * xScale;
    y = y * yScale;
    return irr::core::recti(x, y, x + w, y + h);
  }

  irr::core::recti Game::ResizeCardHint(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
    return ResizeCardMid(x, y, x2, y2, (x + x2) * 0.5, (y + y2) * 0.5);
  }

  irr::core::vector2di Game::ResizeCardHint(irr::s32 x, irr::s32 y) {
    return ResizeCardMid(x, y, x + CARD_IMG_WIDTH * 0.5, y + CARD_IMG_HEIGHT * 0.5);
  }

  irr::core::recti Game::ResizeCardMid(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2, irr::s32 midx, irr::s32 midy) {
    float mul = xScale;
    if (xScale > yScale) {
      mul = yScale;
    }
    irr::s32 cx = midx * xScale;
    irr::s32 cy = midy * yScale;
    x = cx + (x - midx) * mul;
    y = cy + (y - midy) * mul;
    x2 = cx + (x2 - midx) * mul;
    y2 = cy + (y2 - midy) * mul;
    return irr::core::recti(x, y, x2, y2);
  }

  irr::core::vector2di Game::ResizeCardMid(irr::s32 x, irr::s32 y, irr::s32 midx, irr::s32 midy) {
    float mul = xScale;
    if (xScale > yScale) {
      mul = yScale;
    }
    irr::s32 cx = midx * xScale;
    irr::s32 cy = midy * yScale;
    x = cx + (x - midx) * mul;
    y = cy + (y - midy) * mul;
    return irr::core::vector2di(x, y);
  }

  irr::core::recti Game::ResizeFit(irr::s32 x, irr::s32 y, irr::s32 x2, irr::s32 y2) {
    float mul = xScale;
    if (xScale > yScale) {
      mul = yScale;
    }
    x = x * mul;
    y = y * mul;
    x2 = x2 * mul;
    y2 = y2 * mul;
    return irr::core::recti(x, y, x2, y2);
  }

  void Game::SetWindowsIcon() {
#ifdef _WIN32
    auto *hInstance = (HINSTANCE)GetModuleHandleW(nullptr);
    auto *hSmallIcon = (HICON)LoadImageW(hInstance, MAKEINTRESOURCEW(1), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
    auto *hBigIcon = (HICON)LoadImageW(hInstance, MAKEINTRESOURCEW(1), IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
    SendMessageW(hWnd, WM_SETICON, ICON_SMALL, (LPARAM)hSmallIcon);
    SendMessageW(hWnd, WM_SETICON, ICON_BIG, (LPARAM)hBigIcon);
#endif
  }

  void Game::SetWindowsScale(float scale) {
#ifdef _WIN32
    WINDOWPLACEMENT plc;
    plc.length = sizeof(WINDOWPLACEMENT);
    if (GetWindowPlacement(hWnd, &plc) && (plc.showCmd == SW_SHOWMAXIMIZED)) {
      ShowWindow(hWnd, SW_RESTORE);
    }
    RECT rcWindow;
    RECT rcClient;
    GetWindowRect(hWnd, &rcWindow);
    GetClientRect(hWnd, &rcClient);
    MoveWindow(hWnd, rcWindow.left, rcWindow.top, (rcWindow.right - rcWindow.left) - rcClient.right + 1024 * scale, (rcWindow.bottom - rcWindow.top) - rcClient.bottom + 640 * scale, true);
#endif
  }

  void Game::FlashWindow() {
#ifdef _WIN32
    FLASHWINFO fi;
    fi.cbSize = sizeof(FLASHWINFO);
    fi.hwnd = hWnd;
    fi.dwFlags = FLASHW_TRAY | FLASHW_TIMERNOFG;
    fi.uCount = 0;
    fi.dwTimeout = 0;
    FlashWindowEx(&fi);
#endif
  }

  void Game::SetCursor(irr::gui::ECURSOR_ICON icon) {
    irr::gui::ICursorControl *cursor = device->getCursorControl();
    if (cursor->getActiveIcon() != icon) {
      cursor->setActiveIcon(icon);
    }
  }

  fast_io::string Game::get_location_string(int32_t o1, int32_t o2) { // 区域，格子编号

    if (o1 == LOCATION_HAND) {
      return fast_io::concat_fast_io("手卡区域");
    }
    else if (o1 == LOCATION_GRAVE) {
      return fast_io::concat_fast_io("墓地区域", o2, "号格");
    }
    else if (o1 == LOCATION_EXTRA) {
      return fast_io::concat_fast_io("额外卡组区域", o2, "号格");
    }
    else if (o1 == LOCATION_DECK) {
      return fast_io::concat_fast_io("卡组区域");
    }
    else if (o1 == LOCATION_REMOVED) {
      return fast_io::concat_fast_io("除外区域", o2, "号格");
    }
    else if (o1 == LOCATION_MZONE) {
      return fast_io::concat_fast_io("怪兽区域", o2, "号格");
    }
    else if (o1 == LOCATION_SZONE and o2 == 5) {
      return fast_io::concat_fast_io("场地区域");
    }
    else if (o1 == LOCATION_SZONE and o2 == 6) {
      return fast_io::concat_fast_io("灵摆区域", "0号格");
    }
    else if (o1 == LOCATION_SZONE and o2 == 7) {
      return fast_io::concat_fast_io("灵摆区域", "1号格");
    }
    else if (o1 == LOCATION_SZONE) {
      return fast_io::concat_fast_io("魔法与陷阱区域", o2, "号格");
    }
    else {
      return fast_io::concat_fast_io("未命名区域");
    }
  }

  fast_io::string Game::获取表示形式的名称(int32_t o1) { // 表示形式
    if (o1 == POS_FACEUP_ATTACK) {
      return fast_io::concat_fast_io("表侧攻击表示");
    }
    else if (o1 == POS_FACEUP_DEFENSE) {
      return fast_io::concat_fast_io("表侧守备表示");
    }
    else if (o1 == POS_FACEDOWN_DEFENSE) {
      return fast_io::concat_fast_io("里侧守备表示");
    }
  }

  //~ void Game::write_all_bytes(fast_io::obuf_file& o1, uint8_t* o2, uint8_t* o3) {
  //~ using fast_io::operations::write_all_bytes;
  //~ using std::byte;

  //~ write_all_bytes(o1, reinterpret_cast<const byte *>(o2), reinterpret_cast<const byte *>(o3));
  //~ }

} // namespace ygo
