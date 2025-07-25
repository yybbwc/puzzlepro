

namespace ygo {

  intptr_t ReplayMode::pduel = 0;
  Replay ReplayMode::cur_replay;
  bool ReplayMode::is_continuing = true;
  bool ReplayMode::is_closing = false;
  bool ReplayMode::is_pausing = false;
  bool ReplayMode::is_paused = false;
  bool ReplayMode::is_swaping = false;
  bool ReplayMode::is_restarting = false;
  bool ReplayMode::exit_pending = false;
  int ReplayMode::skip_turn = 0;
  int ReplayMode::current_step = 0;
  int ReplayMode::skip_step = 0;

  /*
  $a.2 ReplayMode::$a.3{};
  cc.p
  */
  bool ReplayMode::pauseable{};
  uint8_t *ReplayMode::pbuf{};
  uint8_t *ReplayMode::offset{};

  bool ReplayMode::StartReplay(int skipturn) {
    skip_turn = skipturn;
    if (skip_turn < 0) {
      skip_turn = 0;
    }
    std::thread(ReplayThread).detach();
    return true;
  }

  bool ReplayMode::start_replay(int64_t skip_turn_) {
    skip_turn = skip_turn_;
    if (skip_turn < 0) {
      skip_turn = 0;
    }
    ReplayThread();
    return true;
  }

  void ReplayMode::StopReplay(bool is_exiting) {
    is_pausing = false;
    is_continuing = false;
    is_closing = is_exiting;
    exit_pending = true;
    mainGame->actionSignal.Set();
  }

  void ReplayMode::SwapField() {
    if (is_paused) {
      mainGame->dField.ReplaySwap();
    }
    else {
      is_swaping = true;
    }
  }

  void ReplayMode::Pause(bool is_pause, bool is_step) {
    if (is_pause) {
      is_pausing = true;
    }
    else {
      if (!is_step) {
        is_pausing = false;
      }
      mainGame->actionSignal.Set();
    }
  }

  void ReplayMode::Undo() {
    if (skip_step > 0 || current_step == 0) {
      return;
    }
    is_restarting = true;
    Pause(false, false);
  }

  bool ReplayMode::ReadReplayResponse() {
    unsigned char resp[SIZE_RETURN_VALUE];
    bool result = cur_replay.ReadNextResponse(resp);
    if (result) {
      //~ if (mainGame->as_puzzle_should and !mainGame->replay_finished) {
      //~ SingleMode::last_replay.Write<uint8_t>(SIZE_RETURN_VALUE);
      //~ SingleMode::last_replay.WriteData(resp, SIZE_RETURN_VALUE);
      //~ }
      //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      set_responseb(pduel, resp);
    }
    //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    return result;
  }

  int ReplayMode::ReplayThread() {
    const ReplayHeader &rh = cur_replay.pheader;
    mainGame->dInfo.Clear();
    mainGame->dInfo.isFirst = true;
    mainGame->dInfo.isTag = !!(rh.flag & REPLAY_TAG);
    mainGame->dInfo.isSingleMode = !!(rh.flag & REPLAY_SINGLE_MODE);
    mainGame->dInfo.tag_player[0] = false;
    mainGame->dInfo.tag_player[1] = false;
    set_script_reader(DataManager::ScriptReaderEx);
    set_card_reader(DataManager::CardReader);
    set_message_handler(ReplayMode::MessageHandler);
    if (!StartDuel()) {
      EndDuel();
      return 0;
    }
    mainGame->dInfo.isStarted = true;
    mainGame->dInfo.isFinished = false;
    mainGame->dInfo.isReplay = true;
    mainGame->dInfo.isReplaySkiping = (skip_turn > 0);
    std::vector<unsigned char> engineBuffer;
    engineBuffer.resize(SIZE_MESSAGE_BUFFER);
    is_continuing = true;
    skip_step = 0;
    if (mainGame->dInfo.isSingleMode) {
      int len = get_message(pduel, engineBuffer.data());
      if (len > 0) {
        is_continuing = ReplayAnalyze(engineBuffer.data(), len);
      }
    }
    else {
      ReplayRefreshDeck(0);
      ReplayRefreshDeck(1);
      ReplayRefreshExtra(0);
      ReplayRefreshExtra(1);
    }
    exit_pending = false;
    current_step = 0;
    if (mainGame->dInfo.isReplaySkiping) {
      mainGame->gMutex.lock();
    }
    while (is_continuing && !exit_pending) {
      unsigned int result = process(pduel);
      int len = result & PROCESSOR_BUFFER_LEN;
      if (len > 0) {
        if (len > (int)engineBuffer.size()) {
          engineBuffer.resize(len);
        }
        get_message(pduel, engineBuffer.data());
        is_continuing = ReplayAnalyze(engineBuffer.data(), len);
        if (is_restarting) {
          mainGame->gMutex.lock();
          is_restarting = false;
          mainGame->dInfo.isReplaySkiping = true;
          Restart(false);
          int step = current_step - 1;
          if (step < 0) {
            step = 0;
          }
          if (mainGame->dInfo.isSingleMode) {
            is_continuing = true;
            skip_step = 0;
            int len = get_message(pduel, engineBuffer.data());
            if (len > 0) {
              is_continuing = ReplayAnalyze(engineBuffer.data(), len);
            }
          }
          else {
            ReplayRefreshDeck(0);
            ReplayRefreshDeck(1);
            ReplayRefreshExtra(0);
            ReplayRefreshExtra(1);
          }
          if (step == 0) {
            Pause(true, false);
            mainGame->dInfo.isStarted = true;
            mainGame->dInfo.isFinished = false;
            mainGame->dInfo.isReplaySkiping = false;
            mainGame->dField.RefreshAllCards();
            mainGame->gMutex.unlock();
          }
          skip_step = step;
          current_step = 0;
        }
      }
    }
    if (mainGame->dInfo.isReplaySkiping) {
      mainGame->dInfo.isReplaySkiping = false;
      if (!mainGame->check_replay_should) {
        mainGame->dField.RefreshAllCards();
      }
      mainGame->gMutex.unlock();
    }
    EndDuel();
    //~ if (mainGame->as_puzzle_should) {
    //~ SingleMode::start_record(rh);
    //~ }
    pduel = 0;
    is_continuing = true;
    is_closing = false;
    is_pausing = false;
    is_paused = false;
    is_swaping = false;
    is_restarting = false;
    exit_pending = false;
    skip_turn = 0;
    current_step = 0;
    skip_step = 0;
    return 0;
  }

  bool ReplayMode::StartDuel() {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(mainGame->get_lua()), "config");
    const ReplayHeader &rh = cur_replay.pheader;
    int64_t seed = rh.seed;
    if (mainGame->dInfo.isTag) {
      cur_replay.ReadName(mainGame->dInfo.hostname);
      cur_replay.ReadName(mainGame->dInfo.hostname_tag);
      cur_replay.ReadName(mainGame->dInfo.clientname_tag);
      cur_replay.ReadName(mainGame->dInfo.clientname);
    }
    else {
      cur_replay.ReadName(mainGame->dInfo.hostname);
      cur_replay.ReadName(mainGame->dInfo.clientname);
    }
    pduel = ocgapi_create_duel(seed);
    DuelClient::last_replay_txt.reopen(gui_config["replay_dir"].tostring().append("_last_replay.txt"));
    int start_lp = cur_replay.Read<int32_t>();
    int start_hand = cur_replay.Read<int32_t>();
    int draw_count = cur_replay.Read<int32_t>();
    int opt = cur_replay.Read<int32_t>();
    int duel_rule = opt >> 16;
    mainGame->dInfo.duel_rule = duel_rule;
    set_player_info(pduel, 0, start_lp, start_hand, draw_count);
    set_player_info(pduel, 1, start_lp, start_hand, draw_count);
    mainGame->dInfo.lp[0] = start_lp;
    mainGame->dInfo.lp[1] = start_lp;
    mainGame->dInfo.start_lp = start_lp;
    myswprintf(mainGame->dInfo.strLP[0], L"%d", mainGame->dInfo.lp[0]);
    myswprintf(mainGame->dInfo.strLP[1], L"%d", mainGame->dInfo.lp[1]);
    mainGame->dInfo.turn = 0;
    if (!mainGame->dInfo.isSingleMode) {
      if (!(opt & DUEL_TAG_MODE)) {
        int main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 0, 0, LOCATION_DECK, 0, POS_FACEDOWN_DEFENSE);
        }
        int extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 0, 0, LOCATION_EXTRA, 0, POS_FACEDOWN_DEFENSE);
        }
        mainGame->dField.Initial(mainGame->LocalPlayer(0), main, extra);
        main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 1, 1, LOCATION_DECK, 0, POS_FACEDOWN_DEFENSE);
        }
        extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 1, 1, LOCATION_EXTRA, 0, POS_FACEDOWN_DEFENSE);
        }
        mainGame->dField.Initial(mainGame->LocalPlayer(1), main, extra);
      }
      else {
        int main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 0, 0, LOCATION_DECK, 0, POS_FACEDOWN_DEFENSE);
        }
        int extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 0, 0, LOCATION_EXTRA, 0, POS_FACEDOWN_DEFENSE);
        }
        mainGame->dField.Initial(mainGame->LocalPlayer(0), main, extra);
        main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_tag_card(pduel, cur_replay.Read<int32_t>(), 0, LOCATION_DECK);
        }
        extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_tag_card(pduel, cur_replay.Read<int32_t>(), 0, LOCATION_EXTRA);
        }
        main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 1, 1, LOCATION_DECK, 0, POS_FACEDOWN_DEFENSE);
        }
        extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_card(pduel, cur_replay.Read<int32_t>(), 1, 1, LOCATION_EXTRA, 0, POS_FACEDOWN_DEFENSE);
        }
        mainGame->dField.Initial(mainGame->LocalPlayer(1), main, extra);
        main = cur_replay.Read<int32_t>();
        for (int i = 0; i < main; ++i) {
          new_tag_card(pduel, cur_replay.Read<int32_t>(), 1, LOCATION_DECK);
        }
        extra = cur_replay.Read<int32_t>();
        for (int i = 0; i < extra; ++i) {
          new_tag_card(pduel, cur_replay.Read<int32_t>(), 1, LOCATION_EXTRA);
        }
      }
    }
    else {
      char filename[1024]{};
      auto slen = cur_replay.Read<uint16_t>();
      cur_replay.ReadData(filename, slen);
      filename[slen] = 0;
      if (mainGame->as_puzzle_should) {
        using fast_io::concat_fast_io;
        using fast_io::concat_std;
        //~ using fast_io::mnp::os_c_str;
        SingleMode::filename = concat_fast_io(os_c_str(filename));
        //~ mainGame->replay_relate_single_script_path = concat_std(os_c_str(filename));
        SingleMode::start_record(const_cast<ReplayHeader &>(rh));
      }
      if (!preload_script(pduel, filename)) {
        return false;
      }
    }
    if (!(rh.flag & REPLAY_UNIFORM)) {
      opt |= DUEL_OLD_REPLAY;
    }
    start_duel(pduel, opt);
    return true;
  }

  void ReplayMode::EndDuel() {
    if (mainGame->as_puzzle_should) {
      SingleMode::last_replay.EndRecord();
    }
    DuelClient::last_replay_txt.close();
    end_duel(pduel);
    if (!is_closing) {
      mainGame->actionSignal.Reset();
      mainGame->gMutex.lock();
      mainGame->HideElement(mainGame->wCardSelect);
      mainGame->smMessage->setText_1(dataManager.GetSysString(1501), dataManager.GetSysString(1216));
      //~ if (!mainGame->check_replay_should and !mainGame->solve_puzzle_should) {
      if (!mainGame->check_replay_should) {
        mainGame->PopupElement(mainGame->smMessage);
      }
      mainGame->gMutex.unlock();
      //~ if (!mainGame->check_replay_should and !mainGame->solve_puzzle_should) {
      if (!mainGame->check_replay_should) {
        mainGame->actionSignal.Wait();
      }
      if (mainGame->as_puzzle_should) {
        SingleMode::save_replay();
      }
      mainGame->gMutex.lock();
      mainGame->dInfo.isStarted = false;
      mainGame->dInfo.isInDuel = false;
      mainGame->dInfo.isFinished = true;
      mainGame->dInfo.isReplay = false;
      mainGame->dInfo.isSingleMode = false;
      mainGame->gMutex.unlock();
      mainGame->closeDoneSignal.Reset();
      mainGame->closeSignal.Set();
      mainGame->closeDoneSignal.Wait();
      mainGame->gMutex.lock();
      mainGame->ShowElement(mainGame->wReplay);
      mainGame->check_replay_should = false;
      mainGame->as_puzzle_should = false;
      mainGame->stTip->setVisible(false);
      mainGame->device->setEventReceiver(&mainGame->menuHandler);
      mainGame->gMutex.unlock();
    }
  }

  void ReplayMode::Restart(bool refresh) {
    end_duel(pduel);
    DuelClient::last_replay_txt.close();
    mainGame->dInfo.isStarted = false;
    mainGame->dInfo.isInDuel = false;
    mainGame->dInfo.isFinished = true;
    mainGame->dField.Clear();
    cur_replay.Rewind();
    mainGame->dInfo.tag_player[0] = false;
    mainGame->dInfo.tag_player[1] = false;
    if (!StartDuel()) {
      EndDuel();
    }
    if (refresh) {
      mainGame->dField.RefreshAllCards();
      mainGame->dInfo.isStarted = true;
      mainGame->dInfo.isFinished = false;
    }
    if (mainGame->dInfo.isReplaySwapped) {
      std::swap(mainGame->dInfo.lp[0], mainGame->dInfo.lp[1]);
      std::swap(mainGame->dInfo.strLP[0], mainGame->dInfo.strLP[1]);
      std::swap(mainGame->dInfo.hostname, mainGame->dInfo.clientname);
      std::swap(mainGame->dInfo.hostname_tag, mainGame->dInfo.clientname_tag);
    }
    skip_turn = 0;
  }

  /*
  {$a.1, &ReplayMode::ReplayAnalyze_$a.2},
  cc.p
  */

  using ReplayAnalyze_function = int64_t (*)();
  inline boost::unordered::unordered_flat_map<int64_t, ReplayAnalyze_function> ReplayAnalyze_function_unordered_map = {
    {MSG_RETRY,                &ReplayMode::ReplayAnalyze_MSG_RETRY               },
    {MSG_HINT,                 &ReplayMode::ReplayAnalyze_MSG_HINT                },
    {MSG_WIN,                  &ReplayMode::ReplayAnalyze_MSG_WIN                 },
    {MSG_SELECT_BATTLECMD,     &ReplayMode::ReplayAnalyze_MSG_SELECT_BATTLECMD    },
    {MSG_SELECT_IDLECMD,       &ReplayMode::ReplayAnalyze_MSG_SELECT_IDLECMD      },
    {MSG_SELECT_EFFECTYN,      &ReplayMode::ReplayAnalyze_MSG_SELECT_EFFECTYN     },
    {MSG_SELECT_YESNO,         &ReplayMode::ReplayAnalyze_MSG_SELECT_YESNO        },
    {MSG_SELECT_OPTION,        &ReplayMode::ReplayAnalyze_MSG_SELECT_OPTION       },
    {MSG_SELECT_CARD,          &ReplayMode::ReplayAnalyze_MSG_SELECT_CARD         },
    {MSG_SELECT_TRIBUTE,       &ReplayMode::ReplayAnalyze_MSG_SELECT_CARD         },
    {MSG_SELECT_UNSELECT_CARD, &ReplayMode::ReplayAnalyze_MSG_SELECT_UNSELECT_CARD},
    {MSG_SELECT_CHAIN,         &ReplayMode::ReplayAnalyze_MSG_SELECT_CHAIN        },
    {MSG_SELECT_PLACE,         &ReplayMode::ReplayAnalyze_MSG_SELECT_PLACE        },
    {MSG_SELECT_DISFIELD,      &ReplayMode::ReplayAnalyze_MSG_SELECT_PLACE        },
    {MSG_SELECT_POSITION,      &ReplayMode::ReplayAnalyze_MSG_SELECT_POSITION     },
    {MSG_SELECT_COUNTER,       &ReplayMode::ReplayAnalyze_MSG_SELECT_COUNTER      },
    {MSG_SELECT_SUM,           &ReplayMode::ReplayAnalyze_MSG_SELECT_SUM          },
    {MSG_SORT_CARD,            &ReplayMode::ReplayAnalyze_MSG_SORT_CARD           },
    {MSG_CONFIRM_DECKTOP,      &ReplayMode::ReplayAnalyze_MSG_CONFIRM_DECKTOP     },
    {MSG_CONFIRM_EXTRATOP,     &ReplayMode::ReplayAnalyze_MSG_CONFIRM_EXTRATOP    },
    {MSG_CONFIRM_CARDS,        &ReplayMode::ReplayAnalyze_MSG_CONFIRM_CARDS       },
    {MSG_SHUFFLE_DECK,         &ReplayMode::ReplayAnalyze_MSG_SHUFFLE_DECK        },
    {MSG_SHUFFLE_HAND,         &ReplayMode::ReplayAnalyze_MSG_SHUFFLE_HAND        },
    {MSG_SHUFFLE_EXTRA,        &ReplayMode::ReplayAnalyze_MSG_SHUFFLE_EXTRA       },
    {MSG_REFRESH_DECK,         &ReplayMode::ReplayAnalyze_MSG_REFRESH_DECK        },
    {MSG_SWAP_GRAVE_DECK,      &ReplayMode::ReplayAnalyze_MSG_SWAP_GRAVE_DECK     },
    {MSG_REVERSE_DECK,         &ReplayMode::ReplayAnalyze_MSG_REVERSE_DECK        },
    {MSG_DECK_TOP,             &ReplayMode::ReplayAnalyze_MSG_DECK_TOP            },
    {MSG_SHUFFLE_SET_CARD,     &ReplayMode::ReplayAnalyze_MSG_SHUFFLE_SET_CARD    },
    {MSG_NEW_TURN,             &ReplayMode::ReplayAnalyze_MSG_NEW_TURN            },
    {MSG_NEW_PHASE,            &ReplayMode::ReplayAnalyze_MSG_NEW_PHASE           },
    {MSG_MOVE,                 &ReplayMode::ReplayAnalyze_MSG_MOVE                },
    {MSG_POS_CHANGE,           &ReplayMode::ReplayAnalyze_MSG_POS_CHANGE          },
    {MSG_SET,                  &ReplayMode::ReplayAnalyze_MSG_SET                 },
    {MSG_SWAP,                 &ReplayMode::ReplayAnalyze_MSG_SWAP                },
    {MSG_FIELD_DISABLED,       &ReplayMode::ReplayAnalyze_MSG_FIELD_DISABLED      },
    {MSG_SUMMONING,            &ReplayMode::ReplayAnalyze_MSG_SUMMONING           },
    {MSG_SUMMONED,             &ReplayMode::ReplayAnalyze_MSG_SUMMONED            },
    {MSG_SPSUMMONING,          &ReplayMode::ReplayAnalyze_MSG_SPSUMMONING         },
    {MSG_SPSUMMONED,           &ReplayMode::ReplayAnalyze_MSG_SPSUMMONED          },
    {MSG_FLIPSUMMONING,        &ReplayMode::ReplayAnalyze_MSG_FLIPSUMMONING       },
    {MSG_FLIPSUMMONED,         &ReplayMode::ReplayAnalyze_MSG_FLIPSUMMONED        },
    {MSG_CHAINING,             &ReplayMode::ReplayAnalyze_MSG_CHAINING            },
    {MSG_CHAINED,              &ReplayMode::ReplayAnalyze_MSG_CHAINED             },
    {MSG_CHAIN_SOLVING,        &ReplayMode::ReplayAnalyze_MSG_CHAIN_SOLVING       },
    {MSG_CHAIN_SOLVED,         &ReplayMode::ReplayAnalyze_MSG_CHAIN_SOLVED        },
    {MSG_CHAIN_END,            &ReplayMode::ReplayAnalyze_MSG_CHAIN_END           },
    {MSG_CHAIN_NEGATED,        &ReplayMode::ReplayAnalyze_MSG_CHAIN_NEGATED       },
    {MSG_CHAIN_DISABLED,       &ReplayMode::ReplayAnalyze_MSG_CHAIN_DISABLED      },
    {MSG_CARD_SELECTED,        &ReplayMode::ReplayAnalyze_MSG_CARD_SELECTED       },
    {MSG_RANDOM_SELECTED,      &ReplayMode::ReplayAnalyze_MSG_CARD_SELECTED       },
    {MSG_BECOME_TARGET,        &ReplayMode::ReplayAnalyze_MSG_BECOME_TARGET       },
    {MSG_DRAW,                 &ReplayMode::ReplayAnalyze_MSG_DRAW                },
    {MSG_DAMAGE,               &ReplayMode::ReplayAnalyze_MSG_DAMAGE              },
    {MSG_RECOVER,              &ReplayMode::ReplayAnalyze_MSG_RECOVER             },
    {MSG_EQUIP,                &ReplayMode::ReplayAnalyze_MSG_EQUIP               },
    {MSG_LPUPDATE,             &ReplayMode::ReplayAnalyze_MSG_LPUPDATE            },
    {MSG_UNEQUIP,              &ReplayMode::ReplayAnalyze_MSG_UNEQUIP             },
    {MSG_CARD_TARGET,          &ReplayMode::ReplayAnalyze_MSG_CARD_TARGET         },
    {MSG_CANCEL_TARGET,        &ReplayMode::ReplayAnalyze_MSG_CANCEL_TARGET       },
    {MSG_PAY_LPCOST,           &ReplayMode::ReplayAnalyze_MSG_PAY_LPCOST          },
    {MSG_ADD_COUNTER,          &ReplayMode::ReplayAnalyze_MSG_ADD_COUNTER         },
    {MSG_REMOVE_COUNTER,       &ReplayMode::ReplayAnalyze_MSG_REMOVE_COUNTER      },
    {MSG_ATTACK,               &ReplayMode::ReplayAnalyze_MSG_ATTACK              },
    {MSG_BATTLE,               &ReplayMode::ReplayAnalyze_MSG_BATTLE              },
    {MSG_ATTACK_DISABLED,      &ReplayMode::ReplayAnalyze_MSG_ATTACK_DISABLED     },
    {MSG_DAMAGE_STEP_START,    &ReplayMode::ReplayAnalyze_MSG_DAMAGE_STEP_START   },
    {MSG_DAMAGE_STEP_END,      &ReplayMode::ReplayAnalyze_MSG_DAMAGE_STEP_END     },
    {MSG_MISSED_EFFECT,        &ReplayMode::ReplayAnalyze_MSG_MISSED_EFFECT       },
    {MSG_TOSS_COIN,            &ReplayMode::ReplayAnalyze_MSG_TOSS_COIN           },
    {MSG_TOSS_DICE,            &ReplayMode::ReplayAnalyze_MSG_TOSS_DICE           },
    {MSG_ROCK_PAPER_SCISSORS,  &ReplayMode::ReplayAnalyze_MSG_ROCK_PAPER_SCISSORS },
    {MSG_HAND_RES,             &ReplayMode::ReplayAnalyze_MSG_HAND_RES            },
    {MSG_ANNOUNCE_RACE,        &ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_RACE       },
    {MSG_ANNOUNCE_ATTRIB,      &ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_ATTRIB     },
    {MSG_ANNOUNCE_CARD,        &ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_CARD       },
    {MSG_ANNOUNCE_NUMBER,      &ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_CARD       },
    {MSG_CARD_HINT,            &ReplayMode::ReplayAnalyze_MSG_CARD_HINT           },
    {MSG_PLAYER_HINT,          &ReplayMode::ReplayAnalyze_MSG_PLAYER_HINT         },
    {MSG_MATCH_KILL,           &ReplayMode::ReplayAnalyze_MSG_MATCH_KILL          },
    {MSG_TAG_SWAP,             &ReplayMode::ReplayAnalyze_MSG_TAG_SWAP            },
    {MSG_RELOAD_FIELD,         &ReplayMode::ReplayAnalyze_MSG_RELOAD_FIELD        },
    {MSG_AI_NAME,              &ReplayMode::ReplayAnalyze_MSG_AI_NAME             },
    {MSG_SHOW_HINT,            &ReplayMode::ReplayAnalyze_MSG_SHOW_HINT           },
  };

  int64_t ReplayMode::ReplayAnalyze_(int64_t o1) {
    auto it = ReplayAnalyze_function_unordered_map.find(o1);
    if (it != ReplayAnalyze_function_unordered_map.end()) {
      auto return_value = it->second();
      if (return_value != return_value_further_judge) {
        return return_value;
      }
      else {
        if (pauseable) {
          current_step++;
          if (skip_step) {
            skip_step--;
            if (skip_step == 0) {
              Pause(true, false);
              mainGame->dInfo.isStarted = true;
              mainGame->dInfo.isFinished = false;
              mainGame->dInfo.isReplaySkiping = false;
              mainGame->dField.RefreshAllCards();
              mainGame->gMutex.unlock();
            }
          }
          if (is_pausing) {
            is_paused = true;
            mainGame->actionSignal.Reset();
            mainGame->actionSignal.Wait();
            is_paused = false;
          }
        }
        return return_value;
      }
    }
    else {
      return {}; // 或抛出异常
    }
  }

  bool ReplayMode::ReplayAnalyze(unsigned char *msg, unsigned int len) {
    using luabridge::getGlobal;
    using luabridge::main_thread;

    auto gui_message = getGlobal(main_thread(mainGame->get_lua()), "message");
    auto gui_config = getGlobal(main_thread(mainGame->get_lua()), "config");

    ReplayMode::pbuf = msg;
    int player = 0;
    int count = 0;
    is_restarting = false;
    if (gui_config["message_len_ReplayMode"]) {
      fast_io::io::print(fast_io::win32_box_t(), len, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    }
    while (pbuf - msg < (int)len) {
      if (is_closing) {
        return false;
      }
      if (is_restarting) {
        return true;
      }
      if (is_swaping) {
        mainGame->gMutex.lock();
        mainGame->dField.ReplaySwap();
        mainGame->gMutex.unlock();
        is_swaping = false;
      }
      offset = pbuf;
      pauseable = true;
      mainGame->dInfo.curMsg = BufferIO::ReadUInt8(pbuf);
      if (gui_config["message_ReplayMode"]) {
        fast_io::io::print(fast_io::win32_box_t(), gui_message[mainGame->dInfo.curMsg].tostring(), "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
      }
      auto return_value = ReplayAnalyze_(mainGame->dInfo.curMsg);
      if (return_value != return_value_further_judge) {
        if (mainGame->as_puzzle_should) {
          if (!return_value) {
            if (mainGame->dInfo.isReplaySkiping) {
              ReplayRefresh();
              mainGame->dField.RefreshAllCards();
              mainGame->dInfo.isReplaySkiping = false;
              mainGame->dInfo.isReplay = false;
              SingleMode::is_closing = false;
              SingleMode::is_continuing = true;
              SingleMode::pduel = ReplayMode::pduel;
              mainGame->gMutex.unlock();
            }
            //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
            //~ print_thread_stacktrace("%n %m %f %s %l");
            return SingleMode::SinglePlayAnalyze(offset, pbuf - offset);
          }
          else {
            //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
            return return_value;
          }
        }
        else {
          return return_value;
        }
      }
      //~ fast_io::io::print(fast_io::win32_box_t(), return_value, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    }
    return true;
  }

  /*
bool ReplayMode::ReplayAnalyze_$a.1(uint8_t* pbuf, uint8_t* offset) {
}
cc.p
  */

  int64_t ReplayMode::ReplayAnalyze_MSG_RETRY() {
    if (mainGame->dInfo.isReplaySkiping) {
      mainGame->dInfo.isReplaySkiping = false;
      mainGame->dField.RefreshAllCards();
      mainGame->gMutex.unlock();
    }
    mainGame->check_replay_success = false;
    //~ if (!mainGame->check_replay_should and !mainGame->solve_puzzle_should) {
    if (!mainGame->check_replay_should) {
      mainGame->gMutex.lock();
      mainGame->stMessage->setText(L"Error occurs.");
      mainGame->PopupElement(mainGame->wMessage);
      mainGame->gMutex.unlock();
      mainGame->actionSignal.Reset();
      mainGame->actionSignal.Wait();
    }
    return return_value_end_replay;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_HINT() {
    pbuf += 6;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_WIN() {
    if (mainGame->dInfo.isReplaySkiping) {
      mainGame->dInfo.isReplaySkiping = false;
      //~ if (!mainGame->check_replay_should) {
      mainGame->dField.RefreshAllCards();
      //~ }
      mainGame->gMutex.unlock();
    }
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 1;
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_save_mcst_impl();
    //~ if (mainGame->LocalPlayer(player) == 0) {
    //~ mainGame->solve_puzzle_is_success = true;
    //~ mainGame->chkEnableMusic->setChecked(true);
    //~ }
    //~ }
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_end_replay;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_BATTLECMD() {
    //~ int64_t player;
    //~ int64_t count;
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_chains_size = count;
    //~ }
    pbuf += count * 11;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_attackable_cards_size = count;
    //~ }
    pbuf += count * 8;
    bool can_enter_mp2 = BufferIO::ReadUInt8(pbuf) != 0;
    bool can_enter_ep = BufferIO::ReadUInt8(pbuf) != 0;
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_can_enter_mp2 = can_enter_mp2;
    //~ mainGame->solve_puzzle_can_enter_ep = can_enter_ep;
    //~ }
    ReplayRefresh();
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_BATTLECMD);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_IDLECMD() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_summonable_cards_size = count;
    //~ }
    pbuf += count * 7;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_spsummonable_cards_size = count;
    //~ }
    pbuf += count * 7;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_reposable_cards_size = count;
    //~ }
    pbuf += count * 7;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_msetable_cards_size = count;
    //~ }
    pbuf += count * 7;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_ssetable_cards_size = count;
    //~ }
    pbuf += count * 7;
    count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_chains_size = count;
    //~ }
    pbuf += count * 11;
    bool can_enter_bp = BufferIO::ReadUInt8(pbuf) != 0;
    bool can_enter_ep = BufferIO::ReadUInt8(pbuf) != 0;
    pbuf += 1;
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_can_enter_bp = can_enter_bp;
    //~ mainGame->solve_puzzle_can_enter_ep = can_enter_ep;
    //~ }
    ReplayRefresh();
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_IDLECMD);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_EFFECTYN() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 12;
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_EFFECTYN);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_YESNO() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 4;
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_YESNO);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
    //~ return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_OPTION() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_CARD() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t select_cancelable = BufferIO::ReadUInt8(pbuf) != 0;
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_cancelable = select_cancelable;
    //~ }
    int64_t select_min = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_min = select_min;
    //~ }
    int64_t select_max = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_max = select_max;
    //~ }
    int64_t count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_selectable_cards_size = count;
    //~ }
    pbuf += count * 8;
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_CARD);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_TRIBUTE() {
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_UNSELECT_CARD() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 4;
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 8;
    count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 8;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_CHAIN() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_chains_size = count;
    //~ }
    //~ pbuf += 1;
    //~ specount
    int64_t specount = BufferIO::ReadUInt8(pbuf);
    //~ fast_io::io::print(fast_io::win32_box_t(), specount, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    int64_t forced = BufferIO::ReadUInt8(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_chains_forced = forced;
    //~ }
    pbuf += 8 + count * 13;
    //~ if (mainGame->solve_puzzle_should) {
    //~ if (mainGame->solve_puzzle_select_chains_size == 0) {
    //~ return true;
    //~ }
    //~ else {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_CHAIN);
    //~ }
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_PLACE() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    int64_t selectable_field = ~BufferIO::ReadUInt32(pbuf);
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_select_count = count > 0 ? count : 1;
    //~ mainGame->solve_puzzle_select_cancelable = count == 0;
    //~ mainGame->solve_puzzle_selectable_field = selectable_field;
    //~ }
    //~ if (mainGame->solve_puzzle_should) {
    //~ return mainGame->create_solve_puzzle_behavior(MSG_SELECT_PLACE);
    //~ }
    //~ else {
    return ReadReplayResponse();
    //~ }
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_DISFIELD() {
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_POSITION() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 5;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_COUNTER() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 4;
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 9;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SELECT_SUM() {
    pbuf++;
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 6;
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 11;
    count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 11;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SORT_CARD() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 7;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CONFIRM_DECKTOP() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 7;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CONFIRM_EXTRATOP() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 7;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CONFIRM_CARDS() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 7;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SHUFFLE_DECK() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefreshDeck(player);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SHUFFLE_HAND() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SHUFFLE_EXTRA() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_REFRESH_DECK() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SWAP_GRAVE_DECK() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefreshGrave(player);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_REVERSE_DECK() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefreshDeck(0);
    ReplayRefreshDeck(1);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_DECK_TOP() {
    pbuf += 6;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SHUFFLE_SET_CARD() {
    pbuf++;
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_NEW_TURN() {
    if (skip_turn) {
      skip_turn--;
      if (skip_turn == 0) {
        mainGame->dInfo.isReplaySkiping = false;
        mainGame->dField.RefreshAllCards();
        mainGame->gMutex.unlock();
      }
    }
    int64_t player = BufferIO::ReadUInt8(pbuf);
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_NEW_PHASE() {
    pbuf += 2;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_MOVE() {
    int pc = pbuf[4];
    int pl = pbuf[5];
    int ps = pbuf[6];
    int pp = pbuf[7];
    int cc = pbuf[8];
    int cl = pbuf[9];
    int cs = pbuf[10];
    int cp = pbuf[11];
    pbuf += 16;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    if (cl && !(cl & LOCATION_OVERLAY) && (pl != cl || pc != cc)) {
      ReplayRefreshSingle(cc, cl, cs);
    }
    else if (pl == cl && cl == LOCATION_DECK) {
      ReplayRefreshDeck(cc);
    }
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_POS_CHANGE() {
    pbuf += 9;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SET() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SWAP() {
    pbuf += 16;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_FIELD_DISABLED() {
    pbuf += 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SUMMONING() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SUMMONED() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SPSUMMONING() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SPSUMMONED() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_FLIPSUMMONING() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_FLIPSUMMONED() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAINING() {
    pbuf += 16;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAINED() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAIN_SOLVING() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAIN_SOLVED() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAIN_END() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAIN_NEGATED() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CHAIN_DISABLED() {
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CARD_SELECTED() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_RANDOM_SELECTED() {
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_BECOME_TARGET() {
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_DRAW() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count * 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_DAMAGE() {
    pbuf += 5;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_RECOVER() {
    pbuf += 5;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_EQUIP() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_LPUPDATE() {
    pbuf += 5;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_UNEQUIP() {
    pbuf += 4;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CARD_TARGET() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CANCEL_TARGET() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_PAY_LPCOST() {
    pbuf += 5;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ADD_COUNTER() {
    pbuf += 7;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_REMOVE_COUNTER() {
    pbuf += 7;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ATTACK() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_BATTLE() {
    pbuf += 26;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ATTACK_DISABLED() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_DAMAGE_STEP_START() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_DAMAGE_STEP_END() {
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefresh();
    pauseable = false;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_MISSED_EFFECT() {
    pbuf += 8;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_TOSS_COIN() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_TOSS_DICE() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += count;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ROCK_PAPER_SCISSORS() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_HAND_RES() {
    pbuf += 1;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_RACE() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 5;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_ATTRIB() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    pbuf += 5;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_CARD() {
    int64_t player = BufferIO::ReadUInt8(pbuf);
    int64_t count = BufferIO::ReadUInt8(pbuf);
    pbuf += 4 * count;
    return ReadReplayResponse();
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_ANNOUNCE_NUMBER() {
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_CARD_HINT() {
    pbuf += 9;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_PLAYER_HINT() {
    pbuf += 6;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_MATCH_KILL() {
    pbuf += 4;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_TAG_SWAP() {
    int64_t player = pbuf[0];
    pbuf += pbuf[2] * 4 + pbuf[4] * 4 + 9;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayRefreshDeck(player);
    ReplayRefreshExtra(player);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_RELOAD_FIELD() {
    pbuf++;
    for (int p = 0; p < 2; ++p) {
      pbuf += 4;
      for (int seq = 0; seq < 7; ++seq) {
        int val = BufferIO::ReadUInt8(pbuf);
        if (val) {
          pbuf += 2;
        }
      }
      for (int seq = 0; seq < 8; ++seq) {
        int val = BufferIO::ReadUInt8(pbuf);
        if (val) {
          pbuf++;
        }
      }
      pbuf += 6;
    }
    pbuf++;
    DuelClient::ClientAnalyze(offset, pbuf - offset);
    ReplayReload();
    mainGame->dField.RefreshAllCards();
    //~ if (mainGame->solve_puzzle_should) {
    //~ mainGame->solve_puzzle_your_start_lp = mainGame->dInfo.lp[1];
    //~ mainGame->solve_puzzle_your_start_card = mainGame->dField.hand[1].size() + mainGame->dField.mzone[1].size() + mainGame->dField.szone[1].size();

    //~ auto sum_region = [&](const auto& region) {
    //~ for (int i = 0; i < 2; ++i) {
    //~ offset += 1;
    //~ int64_t total = 0;
    //~ for (const auto& card : region) {
    //~ if (card) {
    //~ total += 1;
    //~ total += static_cast<int64_t>(card->code) * offset;
    //~ fast_io::io::print(fast_io::win32_box_t(), card->code, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    //~ }
    //~ }
    //~ return total;
    //~ }
    //~ };

    /*
  deck
  hand
  mzone
  szone
  grave
  remove
  extra
  cc.gc w a

    mainGame->solve_puzzle_card_move_size_$a.1[0] = mainGame->dField.$a.1[0].size();
    fast_io::io::perr(mainGame->solve_puzzle_card_move_size_$a.1[0], "\t mainGame->solve_puzzle_card_move_size_$a.1[0]", "\n");
    mainGame->solve_puzzle_card_move_size_$a.1[1] = mainGame->dField.$a.1[1].size();
    fast_io::io::perr(mainGame->solve_puzzle_card_move_size_$a.1[1], "\t mainGame->solve_puzzle_card_move_size_$a.1[1]", "\n");
    cc.p

    fast_io::io::perr(mainGame->solve_puzzle_card_move_size_$a.1[0], "\t mainGame->solve_puzzle_card_move_size_$a.1[0]", "\n");
    fast_io::io::perr(mainGame->solve_puzzle_card_move_size_$a.1[1], "\t mainGame->solve_puzzle_card_move_size_$a.1[1]", "\n");

    mainGame->solve_puzzle_card_move_size_$a.1[0] = sum_region(mainGame->dField.$a.1[0]);
    mainGame->solve_puzzle_card_move_size_$a.1[1] = sum_region(mainGame->dField.$a.1[1]);
    cc.p
  */
    //~ mainGame->solve_puzzle_card_move_size_deck[0] = sum_region(mainGame->dField.deck[0]);
    //~ mainGame->solve_puzzle_card_move_size_deck[1] = sum_region(mainGame->dField.deck[1]);
    //~ mainGame->solve_puzzle_card_move_size_hand[0] = sum_region(mainGame->dField.hand[0]);
    //~ mainGame->solve_puzzle_card_move_size_hand[1] = sum_region(mainGame->dField.hand[1]);
    //~ mainGame->solve_puzzle_card_move_size_mzone[0] = sum_region(mainGame->dField.mzone[0]);
    //~ mainGame->solve_puzzle_card_move_size_mzone[1] = sum_region(mainGame->dField.mzone[1]);
    //~ mainGame->solve_puzzle_card_move_size_szone[0] = sum_region(mainGame->dField.szone[0]);
    //~ mainGame->solve_puzzle_card_move_size_szone[1] = sum_region(mainGame->dField.szone[1]);
    //~ mainGame->solve_puzzle_card_move_size_grave[0] = sum_region(mainGame->dField.grave[0]);
    //~ mainGame->solve_puzzle_card_move_size_grave[1] = sum_region(mainGame->dField.grave[1]);
    //~ mainGame->solve_puzzle_card_move_size_remove[0] = sum_region(mainGame->dField.remove[0]);
    //~ mainGame->solve_puzzle_card_move_size_remove[1] = sum_region(mainGame->dField.remove[1]);
    //~ mainGame->solve_puzzle_card_move_size_extra[0] = sum_region(mainGame->dField.extra[0]);
    //~ mainGame->solve_puzzle_card_move_size_extra[1] = sum_region(mainGame->dField.extra[1]);    }
    //~ fast_io::io::print(fast_io::win32_box_t(), mainGame->solve_puzzle_your_start_lp, "\n", __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_AI_NAME() {
    int len = BufferIO::ReadInt16(pbuf);
    pbuf += len + 1;
    return return_value_further_judge;
  }

  int64_t ReplayMode::ReplayAnalyze_MSG_SHOW_HINT() {
    int len = BufferIO::ReadInt16(pbuf);
    pbuf += len + 1;
    return return_value_further_judge;
  }

  inline void ReplayMode::ReloadLocation(int player, int location, int flag, std::vector<unsigned char> &queryBuffer) {
    query_field_card(pduel, player, location, flag, queryBuffer.data(), 0);
    mainGame->dField.UpdateFieldCard(mainGame->LocalPlayer(player), location, queryBuffer.data());
  }

  void ReplayMode::ReplayRefresh(int flag) {
    std::vector<unsigned char> queryBuffer;
    queryBuffer.resize(SIZE_QUERY_BUFFER);
    ReloadLocation(0, LOCATION_MZONE, flag, queryBuffer);
    ReloadLocation(1, LOCATION_MZONE, flag, queryBuffer);
    ReloadLocation(0, LOCATION_SZONE, flag, queryBuffer);
    ReloadLocation(1, LOCATION_SZONE, flag, queryBuffer);
    ReloadLocation(0, LOCATION_HAND, flag, queryBuffer);
    ReloadLocation(1, LOCATION_HAND, flag, queryBuffer);
  }

  void ReplayMode::ReplayRefreshLocation(int player, int location, int flag) {
    std::vector<unsigned char> queryBuffer;
    queryBuffer.resize(SIZE_QUERY_BUFFER);
    ReloadLocation(player, location, flag, queryBuffer);
  }

  inline void ReplayMode::ReplayRefreshHand(int player, int flag) {
    ReplayRefreshLocation(player, LOCATION_HAND, flag);
  }

  inline void ReplayMode::ReplayRefreshGrave(int player, int flag) {
    ReplayRefreshLocation(player, LOCATION_GRAVE, flag);
  }

  inline void ReplayMode::ReplayRefreshDeck(int player, int flag) {
    ReplayRefreshLocation(player, LOCATION_DECK, flag);
  }

  inline void ReplayMode::ReplayRefreshExtra(int player, int flag) {
    ReplayRefreshLocation(player, LOCATION_EXTRA, flag);
  }

  void ReplayMode::ReplayRefreshSingle(int player, int location, int sequence, int flag) {
    unsigned char queryBuffer[0x1000];
    int len = query_card(pduel, player, location, sequence, flag, queryBuffer, 0);
    mainGame->dField.UpdateCard(mainGame->LocalPlayer(player), location, sequence, queryBuffer);
  }

  void ReplayMode::ReplayReload() {
    std::vector<unsigned char> queryBuffer;
    queryBuffer.resize(SIZE_QUERY_BUFFER);
    unsigned int flag = 0xffdfff;
    ReloadLocation(0, LOCATION_MZONE, flag, queryBuffer);
    ReloadLocation(1, LOCATION_MZONE, flag, queryBuffer);
    ReloadLocation(0, LOCATION_SZONE, flag, queryBuffer);
    ReloadLocation(1, LOCATION_SZONE, flag, queryBuffer);
    ReloadLocation(0, LOCATION_HAND, flag, queryBuffer);
    ReloadLocation(1, LOCATION_HAND, flag, queryBuffer);

    ReloadLocation(0, LOCATION_DECK, flag, queryBuffer);
    ReloadLocation(1, LOCATION_DECK, flag, queryBuffer);
    ReloadLocation(0, LOCATION_EXTRA, flag, queryBuffer);
    ReloadLocation(1, LOCATION_EXTRA, flag, queryBuffer);
    ReloadLocation(0, LOCATION_GRAVE, flag, queryBuffer);
    ReloadLocation(1, LOCATION_GRAVE, flag, queryBuffer);
    ReloadLocation(0, LOCATION_REMOVED, flag, queryBuffer);
    ReloadLocation(1, LOCATION_REMOVED, flag, queryBuffer);
  }

  uint32_t ReplayMode::MessageHandler(intptr_t fduel, uint32_t type) {
    if (!enable_log) {
      return 0;
    }
    char msgbuf[1024];
    get_log_message(fduel, msgbuf);
    mainGame->AddDebugMsg(msgbuf);
    return 0;
  }

} // namespace ygo
