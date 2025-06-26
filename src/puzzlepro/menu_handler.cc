

namespace ygo {

  void UpdateDeck() {
    BufferIO::CopyWideString(mainGame->cbCategorySelect->getText(), mainGame->gameConf.lastcategory);
    BufferIO::CopyWideString(mainGame->cbDeckSelect->getText(), mainGame->gameConf.lastdeck);
    unsigned char deckbuf[1024]{};
    auto *pdeck = deckbuf;
    BufferIO::WriteInt32(pdeck, deckManager.current_deck.main.size() + deckManager.current_deck.extra.size());
    BufferIO::WriteInt32(pdeck, deckManager.current_deck.side.size());
    for (size_t i = 0; i < deckManager.current_deck.main.size(); ++i) {
      BufferIO::WriteInt32(pdeck, deckManager.current_deck.main[i]->first);
    }
    for (size_t i = 0; i < deckManager.current_deck.extra.size(); ++i) {
      BufferIO::WriteInt32(pdeck, deckManager.current_deck.extra[i]->first);
    }
    for (size_t i = 0; i < deckManager.current_deck.side.size(); ++i) {
      BufferIO::WriteInt32(pdeck, deckManager.current_deck.side[i]->first);
    }
    DuelClient::SendBufferToServer(CTOS_UPDATE_DECK, deckbuf, pdeck - deckbuf);
  }

  MenuHandler::MenuHandler() {
    using irr::gui::EGFSPE_FILE_CONFIRMED;
    using irr::gui::EGFSPE_REAL_FILE_SELECTED;

    OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function_unordered_map = {
      {EGFSPE_FILE_CONFIRMED,     &MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_FILE_CONFIRMED    },
      {EGFSPE_REAL_FILE_SELECTED, &MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED},
    };

    OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function_unordered_map = {
      {EGFSPE_FILE_CONFIRMED,     &MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_FILE_CONFIRMED    },
      {EGFSPE_REAL_FILE_SELECTED, &MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED},
    };
  }

  bool MenuHandler::OnEvent(const irr::SEvent &event) {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(mainGame->get_lua(boost::this_thread::get_id())), "config");
    using fast_io::wconcat_fast_io;
    using fast_io::mnp::code_cvt_os_c_str;
    if (mainGame->dField.OnCommonEvent(event)) {
      return false;
    }
    switch (event.EventType) {
      case irr::EET_GUI_EVENT: {
        return OnEvent_EET_GUI_EVENT(event);
      }
      default:
        break;
    }
    return false;
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT(const irr::SEvent &event) {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(mainGame->get_lua(boost::this_thread::get_id())), "config");
    using fast_io::wconcat_fast_io;
    using fast_io::mnp::code_cvt_os_c_str;
    irr::gui::IGUIElement *caller = event.GUIEvent.Caller;
    irr::s32 id = caller->getID();
    if (mainGame->wQuery->isVisible() && id != BUTTON_YES && id != BUTTON_NO) {
      mainGame->wQuery->getParent()->bringToFront(mainGame->wQuery);
      return false;
    }
    switch (event.GUIEvent.EventType) {
      case irr::gui::EGET_BUTTON_CLICKED: {
        if (id < 110) {
          soundManager.PlaySoundEffect(SOUND_MENU);
        }
        else {
          soundManager.PlaySoundEffect(SOUND_BUTTON);
        }
        switch (id) {
          case BUTTON_MODE_EXIT: {
            mainGame->device->closeDevice();
            return false;
          }
          case BUTTON_LAN_MODE: {
            mainGame->btnCreateHost->setEnabled(true);
            mainGame->btnJoinHost->setEnabled(true);
            mainGame->btnJoinCancel->setEnabled(true);
            mainGame->HideElement(mainGame->wMainMenu);
            mainGame->ShowElement(mainGame->wLanWindow);
            return false;
          }
          case BUTTON_JOIN_HOST: {
            bot_mode = false;
            mainGame->TrimText(mainGame->ebJoinHost);
            mainGame->TrimText(mainGame->ebJoinPort);
            char ip[20];
            wchar_t pstr[100];
            wchar_t portstr[10];
            BufferIO::CopyWideString(mainGame->ebJoinHost->getText(), pstr);
            BufferIO::CopyWideString(mainGame->ebJoinPort->getText(), portstr);
            BufferIO::EncodeUTF8(pstr, ip);
            unsigned int remote_addr = htonl(inet_addr(ip));
            if (remote_addr == -1) {
              char hostname[100];
              char port[6];
              BufferIO::EncodeUTF8(pstr, hostname);
              BufferIO::EncodeUTF8(portstr, port);
              struct evutil_addrinfo hints;
              struct evutil_addrinfo *answer = nullptr;
              std::memset(&hints, 0, sizeof hints);
              hints.ai_family = AF_INET;
              hints.ai_socktype = SOCK_STREAM;
              hints.ai_protocol = IPPROTO_TCP;
              hints.ai_flags = EVUTIL_AI_ADDRCONFIG;
              int status = evutil_getaddrinfo(hostname, port, &hints, &answer);
              if (status != 0) {
                mainGame->gMutex.lock();
                soundManager.PlaySoundEffect(SOUND_INFO);
                mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1412));
                mainGame->gMutex.unlock();
                return false;
              }
              else {
                sockaddr_in *sin = ((struct sockaddr_in *)answer->ai_addr);
                evutil_inet_ntop(AF_INET, &(sin->sin_addr), ip, 20);
                remote_addr = htonl(inet_addr(ip));
                evutil_freeaddrinfo(answer);
              }
            }
            unsigned int remote_port = std::wcstol(portstr, nullptr, 10);
            BufferIO::CopyWideString(pstr, mainGame->gameConf.lasthost);
            BufferIO::CopyWideString(portstr, mainGame->gameConf.lastport);
            if (DuelClient::StartClient(remote_addr, remote_port, false)) {
              mainGame->btnCreateHost->setEnabled(false);
              mainGame->btnJoinHost->setEnabled(false);
              mainGame->btnJoinCancel->setEnabled(false);
            }
            return false;
          }
          case BUTTON_JOIN_CANCEL: {
            mainGame->HideElement(mainGame->wLanWindow);
            mainGame->ShowElement(mainGame->wMainMenu);
            if (exit_on_return) {
              mainGame->device->closeDevice();
            }
            return false;
          }
          case BUTTON_LAN_REFRESH: {
            DuelClient::BeginRefreshHost();
            return false;
          }
          case BUTTON_CREATE_HOST: {
            mainGame->btnHostConfirm->setEnabled(true);
            mainGame->btnHostCancel->setEnabled(true);
            mainGame->HideElement(mainGame->wLanWindow);
            mainGame->ShowElement(mainGame->wCreateHost);
            return false;
          }
          case BUTTON_HOST_CONFIRM: {
            bot_mode = false;
            BufferIO::CopyWideString(mainGame->ebServerName->getText(), mainGame->gameConf.gamename);
            if (!NetServer::StartServer(mainGame->gameConf.serverport)) {
              soundManager.PlaySoundEffect(SOUND_INFO);
              mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1402));
              return false;
            }
            if (!DuelClient::StartClient(0x7f000001, mainGame->gameConf.serverport)) {
              NetServer::StopServer();
              soundManager.PlaySoundEffect(SOUND_INFO);
              mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1402));
              return false;
            }
            mainGame->btnHostConfirm->setEnabled(false);
            mainGame->btnHostCancel->setEnabled(false);
            return false;
          }
          case BUTTON_HOST_CANCEL: {
            mainGame->btnCreateHost->setEnabled(true);
            mainGame->btnJoinHost->setEnabled(true);
            mainGame->btnJoinCancel->setEnabled(true);
            mainGame->HideElement(mainGame->wCreateHost);
            mainGame->ShowElement(mainGame->wLanWindow);
            return false;
          }
          case BUTTON_HP_DUELIST: {
            mainGame->cbCategorySelect->setEnabled(true);
            mainGame->cbDeckSelect->setEnabled(true);
            DuelClient::SendPacketToServer(CTOS_HS_TODUELIST);
            return false;
          }
          case BUTTON_HP_OBSERVER: {
            DuelClient::SendPacketToServer(CTOS_HS_TOOBSERVER);
            return false;
          }
          case BUTTON_HP_KICK: {
            int index = 0;
            while (index < 4) {
              if (mainGame->btnHostPrepKick[index] == caller) {
                return false;
              }
              ++index;
            }
            CTOS_Kick csk;
            csk.pos = index;
            DuelClient::SendPacketToServer(CTOS_HS_KICK, csk);
            return false;
          }
          case BUTTON_HP_READY: {
            if (mainGame->cbCategorySelect->getSelected() == -1 || mainGame->cbDeckSelect->getSelected() == -1 || !deckManager.LoadCurrentDeck(mainGame->cbCategorySelect->getSelected(), mainGame->cbCategorySelect->getText(), mainGame->cbDeckSelect->getText())) {
              mainGame->gMutex.lock();
              soundManager.PlaySoundEffect(SOUND_INFO);
              mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1406));
              mainGame->gMutex.unlock();
              return false;
            }
            UpdateDeck();
            DuelClient::SendPacketToServer(CTOS_HS_READY);
            mainGame->cbCategorySelect->setEnabled(false);
            mainGame->cbDeckSelect->setEnabled(false);
            return false;
          }
          case BUTTON_HP_NOTREADY: {
            DuelClient::SendPacketToServer(CTOS_HS_NOTREADY);
            mainGame->cbCategorySelect->setEnabled(true);
            mainGame->cbDeckSelect->setEnabled(true);
            return false;
          }
          case BUTTON_HP_START: {
            DuelClient::SendPacketToServer(CTOS_HS_START);
            return false;
          }
          case BUTTON_HP_CANCEL: {
            DuelClient::StopClient();
            mainGame->btnCreateHost->setEnabled(true);
            mainGame->btnJoinHost->setEnabled(true);
            mainGame->btnJoinCancel->setEnabled(true);
            mainGame->btnStartBot->setEnabled(true);
            mainGame->btnBotCancel->setEnabled(true);
            mainGame->HideElement(mainGame->wHostPrepare);
            if (bot_mode) {
              mainGame->ShowElement(mainGame->wSinglePlay);
            }
            else {
              mainGame->ShowElement(mainGame->wLanWindow);
            }
            mainGame->wChat->setVisible(false);
            if (exit_on_return) {
              mainGame->device->closeDevice();
            }
            return false;
          }
          case BUTTON_REPLAY_MODE: {
            mainGame->HideElement(mainGame->wMainMenu);
            mainGame->ShowElement(mainGame->wReplay);
            mainGame->ebRepStartTurn->setText(L"1");
            mainGame->stReplayInfo->setText(L"");
            mainGame->RefreshReplay();
            return false;
          }
          case BUTTON_SINGLE_MODE: {
            mainGame->HideElement(mainGame->wMainMenu);
            mainGame->ShowElement(mainGame->wSinglePlay);
            mainGame->RefreshSingleplay();
            mainGame->RefreshBot();
            return false;
          }
          case BUTTON_LOAD_REPLAY: {
            mainGame->load_replay();
            return false;
          }
          case check_single_replay_button_id: {
            mainGame->check_replay_window->setVisible(true);
            mainGame->check_replay_table->clearRows();
            mainGame->check_replay_vector_0.clear();
            mainGame->check_replay_vector_fail.clear();
            mainGame->check_replay_vector_0.push_back(fast_io::wconcat_std(fast_io::mnp::os_c_str(mainGame->replay_file_select_panel->getSelectedFilePath().c_str())));
            std::thread(mainGame->check_replay_vector_thread).detach();
            return false;
          }
          case solve_puzzle_button_id: {
            mainGame->solve_puzzle_should = true;
            mainGame->solve_puzzle_success = false;
            mainGame->solve_puzzle_window->setVisible(true);
            std::thread(mainGame->solve_puzzle_thread).detach();
            return false;
          }
          case as_puzzle_button_id: {
            mainGame->as_puzzle_should = true;
            mainGame->replay_finished = false;
            SingleMode::is_closing = false;
            SingleMode::is_continuing = true;
            mainGame->singleSignal.SetNoWait(false);
            mainGame->load_replay();
            return false;
          }
          case BUTTON_CANCEL_REPLAY: {
            mainGame->HideElement(mainGame->wReplay);
            mainGame->ShowElement(mainGame->wMainMenu);
            return false;
          }
          case BUTTON_EXPORT_DECK: {
            auto selected = mainGame->lstReplayList->getSelected();
            if (selected == -1) {
              return false;
            }
            Replay replay;
            wchar_t ex_filename[256]{};
            wchar_t namebuf[4][20]{};
            wchar_t filename[256]{};
            wchar_t replay_path[256]{};
            BufferIO::CopyWideString(mainGame->lstReplayList->getListItem(selected), ex_filename);
            myswprintf(replay_path, wconcat_fast_io(code_cvt_os_c_str(gui_config["replay_dir"].tostring().c_str()), L"%ls").c_str(), ex_filename);
            if (!replay.OpenReplay(replay_path)) {
              return false;
            }
            const ReplayHeader &rh = replay.pheader;
            if (rh.flag & REPLAY_SINGLE_MODE) {
              return false;
            }
            int player_count = (rh.flag & REPLAY_TAG) ? 4 : 2;
            // player name
            for (int i = 0; i < player_count; ++i) {
              replay.ReadName(namebuf[i]);
            }
            // skip pre infos
            for (int i = 0; i < 4; ++i) {
              replay.Read<int32_t>();
            }
            // deck
            std::vector<int> deckbuf;
            for (int i = 0; i < player_count; ++i) {
              deckbuf.clear();
              int main = replay.Read<int32_t>();
              deckbuf.push_back(main);
              for (int j = 0; j < main; ++j) {
                deckbuf.push_back(replay.Read<int32_t>());
              }
              int extra = replay.Read<int32_t>();
              deckbuf.push_back(extra);
              for (int j = 0; j < extra; ++j) {
                deckbuf.push_back(replay.Read<int32_t>());
              }
              deckbuf.push_back(0);
              FileSystem::SafeFileName(namebuf[i]);
              myswprintf(filename, L"deck/%ls-%d %ls.ydk", ex_filename, i + 1, namebuf[i]);
              deckManager.SaveDeckBuffer(deckbuf.data(), filename);
            }
            mainGame->stACMessage->setText(dataManager.GetSysString(1335));
            mainGame->PopupElement(mainGame->wACMessage, 20);
            return false;
          }
          case BUTTON_BOT_START: {
            int sel = mainGame->lstBotList->getSelected();
            if (sel == -1) {
              return false;
            }
            bot_mode = true;
            if (!NetServer::StartServer(mainGame->gameConf.serverport)) {
              soundManager.PlaySoundEffect(SOUND_INFO);
              mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1402));
              return false;
            }
            if (!DuelClient::StartClient(0x7f000001, mainGame->gameConf.serverport)) {
              NetServer::StopServer();
              soundManager.PlaySoundEffect(SOUND_INFO);
              mainGame->guiEnv->addMessageBox(L"", dataManager.GetSysString(1402));
              return false;
            }
            STARTUPINFOW si;
            PROCESS_INFORMATION pi;
            ZeroMemory(&si, sizeof(si));
            si.cb = sizeof(si);
            ZeroMemory(&pi, sizeof(pi));
            wchar_t cmd[MAX_PATH];
            wchar_t arg1[512];
            if (mainGame->botInfo[sel].select_deckfile) {
              wchar_t botdeck[256];
              DeckManager::GetDeckFile(botdeck, mainGame->cbBotDeckCategory->getSelected(), mainGame->cbBotDeckCategory->getText(), mainGame->cbBotDeck->getText());
              myswprintf(arg1, L"%ls DeckFile='%ls'", mainGame->botInfo[sel].command, botdeck);
            }
            else {
              myswprintf(arg1, L"%ls", mainGame->botInfo[sel].command);
            }
            int flag = 0;
            flag += (mainGame->chkBotHand->isChecked() ? 0x1 : 0);
            myswprintf(cmd, L"Bot.exe \"%ls\" %d %d", arg1, flag, mainGame->gameConf.serverport);
            if (!CreateProcessW(nullptr, cmd, nullptr, nullptr, FALSE, 0, nullptr, nullptr, &si, &pi)) {
              NetServer::StopServer();
              return false;
            }
            mainGame->btnStartBot->setEnabled(false);
            mainGame->btnBotCancel->setEnabled(false);
            return false;
          }
          case BUTTON_LOAD_SINGLEPLAY: {
            if (mainGame->single_file_select_panel->getSelectedFilePath().empty()) {
              return false;
            }
            mainGame->singleSignal.SetNoWait(false);
            SingleMode::StartPlay();
            return false;
          }
          case BUTTON_CANCEL_SINGLEPLAY: {
            mainGame->HideElement(mainGame->wSinglePlay);
            mainGame->ShowElement(mainGame->wMainMenu);
            return false;
          }
          case BUTTON_DECK_EDIT: {
            mainGame->RefreshCategoryDeck(mainGame->cbDBCategory, mainGame->cbDBDecks);
            if (open_file && deckManager.LoadCurrentDeck(open_file_name)) {
              wchar_t *dash = std::wcsrchr(open_file_name, L'\\');
              wchar_t *dot = std::wcsrchr(open_file_name, L'.');
              if (dash && dot && !mywcsncasecmp(dot, L".ydk", 4)) { // full path
                wchar_t deck_name[256];
                std::wcsncpy(deck_name, dash + 1, dot - dash - 1);
                deck_name[dot - dash - 1] = L'\0';
                mainGame->ebDeckname->setText(deck_name);
                mainGame->cbDBCategory->setSelected(-1);
                mainGame->cbDBDecks->setSelected(-1);
                mainGame->btnManageDeck->setEnabled(false);
                mainGame->cbDBCategory->setEnabled(false);
                mainGame->cbDBDecks->setEnabled(false);
              }
              else if (dash) { // has category
                wchar_t deck_name[256];
                std::wcsncpy(deck_name, dash + 1, 256);
                for (size_t i = 0; i < mainGame->cbDBDecks->getItemCount(); ++i) {
                  if (!std::wcscmp(mainGame->cbDBDecks->getItem(i), deck_name)) {
                    BufferIO::CopyWideString(deck_name, mainGame->gameConf.lastdeck);
                    mainGame->cbDBDecks->setSelected(i);
                    return false;
                  }
                }
              }
              else { // only deck name
                for (size_t i = 0; i < mainGame->cbDBDecks->getItemCount(); ++i) {
                  if (!std::wcscmp(mainGame->cbDBDecks->getItem(i), open_file_name)) {
                    BufferIO::CopyWideString(open_file_name, mainGame->gameConf.lastdeck);
                    mainGame->cbDBDecks->setSelected(i);
                    return false;
                  }
                }
              }
              open_file = false;
            }
            else if (mainGame->cbDBCategory->getSelected() != -1 && mainGame->cbDBDecks->getSelected() != -1) {
              deckManager.LoadCurrentDeck(mainGame->cbDBCategory->getSelected(), mainGame->cbDBCategory->getText(), mainGame->cbDBDecks->getText());
              mainGame->ebDeckname->setText(L"");
            }
            mainGame->HideElement(mainGame->wMainMenu);
            mainGame->deckBuilder.Initialize();
            return false;
          }
          case BUTTON_YES: {
            mainGame->HideElement(mainGame->wQuery);
            prev_operation = 0;
            prev_sel = -1;
            return false;
          }
          case BUTTON_NO: {
            mainGame->HideElement(mainGame->wQuery);
            prev_operation = 0;
            prev_sel = -1;
            return false;
          }
          case BUTTON_REPLAY_CANCEL: {
            mainGame->HideElement(mainGame->wReplaySave);
            prev_operation = 0;
            prev_sel = -1;
            return false;
          }
        }
        return false;
      }
      case irr::gui::EGET_MESSAGEBOX_OK: {
        soundManager.PlaySoundEffect(SOUND_BUTTON);
        mainGame->HideElement(mainGame->smMessage);
        mainGame->actionSignal.Set();
        return false;
      }
      case irr::gui::EGET_MESSAGEBOX_CANCEL: {
        soundManager.PlaySoundEffect(SOUND_BUTTON);
        mainGame->HideElement(mainGame->smMessage);
        mainGame->actionSignal.Set();
        return false;
      }
      case irr::gui::EGET_FILE_SELECTED: {
        return OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED(id);
      }
      case irr::gui::EGET_LISTBOX_CHANGED: {
        switch (id) {
          case LISTBOX_LAN_HOST: {
            int sel = mainGame->lstHostList->getSelected();
            if (sel == -1) {
              return false;
            }
            int addr = DuelClient::hosts[sel].ipaddr;
            int port = DuelClient::hosts[sel].port;
            wchar_t buf[20];
            myswprintf(buf, L"%d.%d.%d.%d", addr & 0xff, (addr >> 8) & 0xff, (addr >> 16) & 0xff, (addr >> 24) & 0xff);
            mainGame->ebJoinHost->setText(buf);
            myswprintf(buf, L"%d", port);
            mainGame->ebJoinPort->setText(buf);
            return false;
          }
          case LISTBOX_SINGLEPLAY_LIST: {
            return false;
          }
          case LISTBOX_BOT_LIST: {
            int sel = mainGame->lstBotList->getSelected();
            if (sel == -1) {
              return false;
            }
            mainGame->SetStaticText(mainGame->stBotInfo, mainGame->stBotInfo->getRelativePosition().getWidth(), mainGame->guiFont, mainGame->botInfo[sel].desc);
            mainGame->cbBotDeckCategory->setVisible(mainGame->botInfo[sel].select_deckfile);
            mainGame->cbBotDeck->setVisible(mainGame->botInfo[sel].select_deckfile);
            return false;
          }
        }
        return false;
      }
      case irr::gui::EGET_CHECKBOX_CHANGED: {
        switch (id) {
          case CHECKBOX_HP_READY: {
            if (!caller->isEnabled()) {
              return false;
            }
            mainGame->guiEnv->setFocus(mainGame->wHostPrepare);
            if (static_cast<irr::gui::IGUICheckBox *>(caller)->isChecked()) {
              if (mainGame->cbCategorySelect->getSelected() == -1 || mainGame->cbDeckSelect->getSelected() == -1 || !deckManager.LoadCurrentDeck(mainGame->cbCategorySelect->getSelected(), mainGame->cbCategorySelect->getText(), mainGame->cbDeckSelect->getText())) {
                mainGame->gMutex.lock();
                static_cast<irr::gui::IGUICheckBox *>(caller)->setChecked(false);
                soundManager.PlaySoundEffect(SOUND_INFO);
                mainGame->guiEnv->addMessageBox(L"消息", dataManager.GetSysString(1406), false);
                mainGame->gMutex.unlock();
                return false;
              }
              UpdateDeck();
              DuelClient::SendPacketToServer(CTOS_HS_READY);
              mainGame->cbCategorySelect->setEnabled(false);
              mainGame->cbDeckSelect->setEnabled(false);
            }
            else {
              DuelClient::SendPacketToServer(CTOS_HS_NOTREADY);
              mainGame->cbCategorySelect->setEnabled(true);
              mainGame->cbDeckSelect->setEnabled(true);
            }
            return false;
          }
        }
        return false;
      }
      case irr::gui::EGET_COMBO_BOX_CHANGED: {
        switch (id) {
          case COMBOBOX_BOT_RULE: {
            mainGame->RefreshBot();
            return false;
          }
          case COMBOBOX_HP_CATEGORY: {
            int catesel = mainGame->cbCategorySelect->getSelected();
            if (catesel == 3) {
              catesel = 2;
              mainGame->cbCategorySelect->setSelected(2);
            }
            if (catesel >= 0) {
              mainGame->RefreshDeck(mainGame->cbCategorySelect, mainGame->cbDeckSelect);
              mainGame->cbDeckSelect->setSelected(0);
            }
            return false;
          }
          case COMBOBOX_BOT_DECKCATEGORY: {
            int catesel = mainGame->cbBotDeckCategory->getSelected();
            if (catesel == 3) {
              catesel = 2;
              mainGame->cbBotDeckCategory->setSelected(2);
            }
            if (catesel >= 0) {
              mainGame->RefreshDeck(mainGame->cbBotDeckCategory, mainGame->cbBotDeck);
              mainGame->cbBotDeck->setSelected(0);
            }
            return false;
          }
        }
        return false;
      }
      default:
        return false;
    }
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED(int64_t id) {
    if (id == single_file_select_panel_id) {
      return OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id();
    }
    else if (id == replay_file_select_panel_id) {
      return OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id();
    }
    return false;
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id() {
    if (!ReplayMode::cur_replay.OpenReplay(mainGame->replay_file_select_panel->getSelectedFilePath().c_str())) {
      mainGame->stReplayInfo->setText(L"");
      return false;
    }
    auto it = OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function_unordered_map.find(mainGame->replay_file_select_panel->getLastEvent());
    if (it != OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_function_unordered_map.end()) {
      return (this->*(it->second))();
    }
    return {};
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED() {
    wchar_t infobuf[256]{};
    std::wstring repinfo;
    time_t curtime = 0;
    if (ReplayMode::cur_replay.pheader.flag & REPLAY_UNIFORM) {
      curtime = ReplayMode::cur_replay.pheader.start_time;
    }
    else {
      curtime = ReplayMode::cur_replay.pheader.seed;
    }
    std::wcsftime(infobuf, sizeof infobuf / sizeof infobuf[0], L"%Y/%m/%d %H:%M:%S\n", std::localtime(&curtime));
    repinfo.append(infobuf);
    wchar_t namebuf[4][20]{};
    ReplayMode::cur_replay.ReadName(namebuf[0]);
    ReplayMode::cur_replay.ReadName(namebuf[1]);
    if (ReplayMode::cur_replay.pheader.flag & REPLAY_TAG) {
      ReplayMode::cur_replay.ReadName(namebuf[2]);
      ReplayMode::cur_replay.ReadName(namebuf[3]);
    }
    if (ReplayMode::cur_replay.pheader.flag & REPLAY_TAG) {
      myswprintf(infobuf, L"%ls\n%ls\n===VS===\n%ls\n%ls\n", namebuf[0], namebuf[1], namebuf[2], namebuf[3]);
    }
    else {
      myswprintf(infobuf, L"%ls\n===VS===\n%ls\n", namebuf[0], namebuf[1]);
    }
    repinfo.append(infobuf);
    mainGame->ebRepStartTurn->setText(L"1");
    mainGame->SetStaticText(mainGame->stReplayInfo, 180, mainGame->guiFont, repinfo.c_str());
    return false;
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_replay_file_select_panel_id_EGFSPE_FILE_CONFIRMED() {
    mainGame->load_replay();
    return false;
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id() {
    if (!mainGame->single_file_select_panel->isSelectedFileReal()) {
      return false;
    }
    auto it = OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function_unordered_map.find(mainGame->single_file_select_panel->getLastEvent());
    if (it != OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_function_unordered_map.end()) {
      return (this->*(it->second))();
    }
    return {};
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_FILE_CONFIRMED() {
    mainGame->singleSignal.SetNoWait(false);
    SingleMode::StartPlay();
    return false;
  }

  bool MenuHandler::OnEvent_EET_GUI_EVENT_EGET_FILE_SELECTED_single_file_select_panel_id_EGFSPE_REAL_FILE_SELECTED() {
    using boost::regex;
    using boost::algorithm::find_regex;
    using boost::algorithm::trim_copy;
    using fast_io::native_file_loader;
    using fast_io::wconcat_std;
    using fast_io::mnp::code_cvt;
    using fast_io::mnp::os_c_str;

    native_file_loader file(mainGame->single_file_select_panel->getSelectedFilePath());
    auto result = wconcat_std(code_cvt(os_c_str(trim_copy(find_regex(file, regex("(?<=--\\[\\[message)(.(?![\n\r]+\\]\\]))+."))))));
    mainGame->stSinglePlayInfo->setText(result.c_str());

    return false;
  }

  void Game::load_replay() {
    if (replay_file_select_panel->getSelectedFilePath().empty()) {
      return;
    }
    if (!ReplayMode::cur_replay.OpenReplay(replay_file_select_panel->getSelectedFilePath().c_str())) {
      return;
    }
    ClearCardInfo();
    wCardImg->setVisible(true);
    wInfos->setVisible(true);
    //~ wReplay->setVisible(true);
    if (!mainGame->as_puzzle_should) {
      wReplayControl->setVisible(true);
      btnReplayStart->setVisible(false);
      btnReplayPause->setVisible(true);
      btnReplayStep->setVisible(false);
      btnReplayUndo->setVisible(false);
    }
    else {
      mainGame->chain_timing_combo_box->setVisible(true);
      mainGame->dField.UpdateChainButtons();
      mainGame->btnLeaveGame->setText(dataManager.GetSysString(1351));
      mainGame->btnLeaveGame->setVisible(true);
    }
    wPhase->setVisible(true);
    dField.Clear();
    HideElement(wReplay);
    device->setEventReceiver(&dField);
    unsigned int start_turn = std::wcstol(ebRepStartTurn->getText(), nullptr, 10);
    if (mainGame->check_single_replay_should or mainGame->as_puzzle_should) {
      start_turn = 10;
    }
    else if (start_turn == 1) {
      start_turn = 0;
    }
    ReplayMode::StartReplay(start_turn);
  }

  void Game::check_replay_vector_thread() {
    for (int64_t i = 0, n = mainGame->check_replay_vector_0.size(); i != n; ++i) {
      auto t0(fast_io::posix_clock_gettime(fast_io::posix_clock_id::monotonic_raw));
      mainGame->check_single_replay_should = true;
      mainGame->check_single_replay_success = true;
      int64_t row_count = mainGame->check_replay_table->addRow(mainGame->check_replay_table->getRowCount());
      mainGame->check_replay_table->setCellText(row_count, 0, mainGame->check_replay_vector_0[i].c_str());
      if (!ReplayMode::cur_replay.OpenReplay(mainGame->check_replay_vector_0[i].c_str())) {
        mainGame->check_single_replay_should = false;
        mainGame->check_replay_table->setCellText(row_count, 1, dataManager.GetSysString(4008));
        break;
      }
      mainGame->check_replay_vector_thread_impl();
      if (mainGame->check_single_replay_success) {
        mainGame->check_replay_table->setCellText(row_count, 1, dataManager.GetSysString(4007));
      }
      else {
        mainGame->check_replay_table->setCellText(row_count, 1, dataManager.GetSysString(4008));
        mainGame->check_replay_vector_fail.push_back(1);
      }
      auto t1(fast_io::posix_clock_gettime(fast_io::posix_clock_id::monotonic_raw));
      mainGame->check_replay_table->setCellText(row_count, 2, fast_io::wconcat_std(t1 - t0, L"s").c_str());
    }
    int64_t row_count = mainGame->check_replay_table->addRow(mainGame->check_replay_table->getRowCount());
    mainGame->check_replay_table->setCellText(row_count, 0, fast_io::wconcat_std(mainGame->check_replay_vector_fail.size(), L"/", mainGame->check_replay_vector_0.size()).c_str());
  }

  void Game::check_replay_vector_thread_impl() {
    ClearCardInfo();
    wCardImg->setVisible(true);
    wInfos->setVisible(true);
    //~ wReplay->setVisible(true);
    wReplayControl->setVisible(true);
    btnReplayStart->setVisible(false);
    btnReplayPause->setVisible(true);
    btnReplayStep->setVisible(false);
    btnReplayUndo->setVisible(false);
    wPhase->setVisible(true);
    dField.Clear();
    HideElement(wReplay);
    device->setEventReceiver(&dField);
    unsigned int start_turn = std::wcstol(ebRepStartTurn->getText(), nullptr, 10);
    if (start_turn == 1) {
      start_turn = 0;
    }
    if (mainGame->check_single_replay_should) {
      start_turn = 10;
    }
    ReplayMode::start_replay(start_turn);
    //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
  }

  void Game::solve_puzzle_thread() {
    mainGame->solve_puzzle_table->addRow(0);
    int64_t fail_count = 0;
    mainGame->solve_puzzle_spend_time = 0;
    mainGame->solve_puzzle_string_s1.clear();
    for (; !mainGame->solve_puzzle_success;) {
      mainGame->solve_puzzle_string.clear();
      auto t0(fast_io::posix_clock_gettime(fast_io::posix_clock_id::monotonic_raw));
      //~ int64_t row_count = mainGame->solve_puzzle_table->addRow(mainGame->solve_puzzle_table->getRowCount());
      mainGame->solve_puzzle_thread_impl();
      auto t1(fast_io::posix_clock_gettime(fast_io::posix_clock_id::monotonic_raw));
      mainGame->solve_puzzle_spend_time += static_cast<double>(t1 - t0);
      //~ mainGame->solve_puzzle_spend_time += t1 - t0;
      if (mainGame->solve_puzzle_success) {
        //~ mainGame->solve_puzzle_table->setCellText(row_count, 0, dataManager.GetSysString(4007));
        //~ auto t1(fast_io::posix_clock_gettime(fast_io::posix_clock_id::monotonic_raw));
        //~ mainGame->solve_puzzle_table->setCellText(row_count, 1, fast_io::wconcat_std(t1 - t0, L"s").c_str());
        //~ mainGame->solve_puzzle_success
        fast_io::obuf_file solve_puzzle_txt{"./replay/_solve_puzzle.txt"};
        fast_io::io::print(solve_puzzle_txt, mainGame->solve_puzzle_string);
        break;
      }
      else {
        fail_count += 1;
        mainGame->solve_puzzle_table->setCellText(0, 0, fast_io::wconcat_std(fail_count).c_str());
        mainGame->solve_puzzle_table->setCellText(0, 1, fast_io::wconcat_std(mainGame->solve_puzzle_spend_time, L"s").c_str());
      }
      //~ mainGame->solve_puzzle_table->setCellText(row_count, 1, fast_io::wconcat_std(t1 - t0, L"s").c_str());
      //~ mainGame->solve_puzzle_table->setCellText(0, 0, fast_io::wconcat_std(fast_io::mnp::os_c_str(dataManager.GetSysString(4008)), L": ", fail_count).c_str());
    }
    mainGame->solve_puzzle_should = false;
  }

  void Game::solve_puzzle_thread_impl() {
    if (replay_file_select_panel->getSelectedFilePath().empty()) {
      return;
    }
    if (!ReplayMode::cur_replay.OpenReplay(replay_file_select_panel->getSelectedFilePath().c_str())) {
      return;
    }
    ClearCardInfo();
    wCardImg->setVisible(true);
    wInfos->setVisible(true);
    wReplayControl->setVisible(true);
    btnReplayStart->setVisible(false);
    btnReplayPause->setVisible(true);
    btnReplayStep->setVisible(false);
    btnReplayUndo->setVisible(false);
    wPhase->setVisible(true);
    dField.Clear();
    HideElement(wReplay);
    device->setEventReceiver(&dField);
    unsigned int start_turn = std::wcstol(ebRepStartTurn->getText(), nullptr, 10);
    if (start_turn == 1) {
      start_turn = 0;
    }
    else if (mainGame->check_single_replay_should) {
      start_turn = 10;
    }
    ReplayMode::start_replay(start_turn);
  }

} // namespace ygo
