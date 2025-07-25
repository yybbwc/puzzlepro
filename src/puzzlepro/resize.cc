namespace ygo {
  void Game::init_resize_element_unordered_map() {
    //~ should_resize_element_unordered_map_int.insert_or_assign(wCardImg, "wCardImg");
    should_resize_element_unordered_map_int.insert_or_assign(imgCard, "imgCard");

    should_resize_element_unordered_map_int.insert_or_assign(wInfos, "wInfos");
    should_resize_element_unordered_map_int.insert_or_assign(stDataInfo, "stDataInfo");

    should_resize_element_unordered_map_int.insert_or_assign(wMainMenu, "wMainMenu");
    should_resize_element_unordered_map_int.insert_or_assign(btnLanMode, "btnLanMode");
    should_resize_element_unordered_map_int.insert_or_assign(btnSingleMode, "btnSingleMode");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayMode, "btnReplayMode");
    should_resize_element_unordered_map_int.insert_or_assign(btnDeckEdit, "btnDeckEdit");
    should_resize_element_unordered_map_int.insert_or_assign(btnModeExit, "btnModeExit");

    should_resize_element_unordered_map_int.insert_or_assign(check_replay_window, "check_replay_window");
    should_resize_element_unordered_map_int.insert_or_assign(check_replay_table, "check_replay_table");
    should_resize_element_unordered_map_int.insert_or_assign(check_replay_static_text, "check_replay_static_text");

    //~ should_resize_element_unordered_map_int.insert_or_assign(solve_puzzle_window, "solve_puzzle_window");
    //~ should_resize_element_unordered_map_int.insert_or_assign(solve_puzzle_table, "solve_puzzle_table");

    should_resize_element_unordered_map_int.insert_or_assign(wReplay, "wReplay");
    //~ should_resize_element_unordered_map_int.insert_or_assign(lstReplayList, "lstReplayList");
    should_resize_element_unordered_map_int.insert_or_assign(stReplayTip, "stReplayTip");
    should_resize_element_unordered_map_int.insert_or_assign(stReplayInfo, "stReplayInfo");
    should_resize_element_unordered_map_int.insert_or_assign(replay_file_select_panel, "replay_file_select_panel");
    should_resize_element_unordered_map_int.insert_or_assign(replay_panel, "replay_panel");
    should_resize_element_unordered_map_int.insert_or_assign(stReplayTurnTip, "stReplayTurnTip");
    should_resize_element_unordered_map_int.insert_or_assign(ebRepStartTurn, "ebRepStartTurn");
    should_resize_element_unordered_map_int.insert_or_assign(btnLoadReplay, "btnLoadReplay");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayCancel, "btnReplayCancel");
    should_resize_element_unordered_map_int.insert_or_assign(btnExportDeck, "btnExportDeck");
    should_resize_element_unordered_map_int.insert_or_assign(check_single_replay_button, "check_single_replay_button");
    should_resize_element_unordered_map_int.insert_or_assign(check_single_layer_replay_button, "check_single_layer_replay_button");
    should_resize_element_unordered_map_int.insert_or_assign(check_multi_layer_replay_button, "check_multi_layer_replay_button");
    //~ should_resize_element_unordered_map_int.insert_or_assign(solve_puzzle_button, "solve_puzzle_button");
    should_resize_element_unordered_map_int.insert_or_assign(as_puzzle_button, "as_puzzle_button");

    should_resize_element_unordered_map_int.insert_or_assign(wSinglePlay, "wSinglePlay");
    should_resize_element_unordered_map_int.insert_or_assign(wSingle, "wSingle");
    should_resize_element_unordered_map_int.insert_or_assign(lstBotList, "lstBotList");
    should_resize_element_unordered_map_int.insert_or_assign(btnStartBot, "btnStartBot");
    should_resize_element_unordered_map_int.insert_or_assign(btnBotCancel, "btnBotCancel");
    should_resize_element_unordered_map_int.insert_or_assign(stBotTip, "stBotTip");
    should_resize_element_unordered_map_int.insert_or_assign(stBotInfo, "stBotInfo");
    should_resize_element_unordered_map_int.insert_or_assign(cbBotDeckCategory, "cbBotDeckCategory");
    should_resize_element_unordered_map_int.insert_or_assign(cbBotDeck, "cbBotDeck");
    should_resize_element_unordered_map_int.insert_or_assign(cbBotRule, "cbBotRule");
    should_resize_element_unordered_map_int.insert_or_assign(chkBotHand, "chkBotHand");
    should_resize_element_unordered_map_int.insert_or_assign(chkBotNoCheckDeck, "chkBotNoCheckDeck");
    should_resize_element_unordered_map_int.insert_or_assign(chkBotNoShuffleDeck, "chkBotNoShuffleDeck");
    should_resize_element_unordered_map_int.insert_or_assign(single_file_select_panel, "single_file_select_panel");
    should_resize_element_unordered_map_int.insert_or_assign(btnLoadSinglePlay, "btnLoadSinglePlay");
    should_resize_element_unordered_map_int.insert_or_assign(btnSinglePlayCancel, "btnSinglePlayCancel");
    should_resize_element_unordered_map_int.insert_or_assign(stSinglePlayTip, "stSinglePlayTip");
    should_resize_element_unordered_map_int.insert_or_assign(stSinglePlayInfo, "stSinglePlayInfo");
    should_resize_element_unordered_map_int.insert_or_assign(chkSinglePlayReturnDeckTop, "chkSinglePlayReturnDeckTop");

    should_resize_element_unordered_map_int.insert_or_assign(wPhase, "wPhase");
    should_resize_element_unordered_map_int.insert_or_assign(btnBP, "btnBP");
    should_resize_element_unordered_map_int.insert_or_assign(btnM2, "btnM2");
    should_resize_element_unordered_map_int.insert_or_assign(btnEP, "btnEP");

    should_resize_element_unordered_map_int.insert_or_assign(wReplaySave, "wReplaySave");
    should_resize_element_unordered_map_int.insert_or_assign(stReplaySave, "stReplaySave");
    should_resize_element_unordered_map_int.insert_or_assign(ebRSName, "ebRSName");
    should_resize_element_unordered_map_int.insert_or_assign(btnRSNo, "btnRSNo");
    should_resize_element_unordered_map_int.insert_or_assign(wPosSelect, "wPosSelect");
    should_resize_element_unordered_map_int.insert_or_assign(btnPSAU, "btnPSAU");
    should_resize_element_unordered_map_int.insert_or_assign(btnPSAD, "btnPSAD");
    should_resize_element_unordered_map_int.insert_or_assign(btnPSDU, "btnPSDU");
    should_resize_element_unordered_map_int.insert_or_assign(btnPSDD, "btnPSDD");
    should_resize_element_unordered_map_int.insert_or_assign(wCardSelect, "wCardSelect");
    should_resize_element_unordered_map_int.insert_or_assign(scrCardList, "scrCardList");
    should_resize_element_unordered_map_int.insert_or_assign(btnSelectOK, "btnSelectOK");

    should_resize_element_unordered_map_int.insert_or_assign(wReplayControl, "wReplayControl");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayStart, "btnReplayStart");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayPause, "btnReplayPause");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayStep, "btnReplayStep");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayUndo, "btnReplayUndo");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplaySwap, "btnReplaySwap");
    should_resize_element_unordered_map_int.insert_or_assign(btnReplayExit, "btnReplayExit");

    should_resize_element_unordered_map_int.insert_or_assign(wFilter, "wFilter");
    should_resize_element_unordered_map_int.insert_or_assign(stCategory, "stCategory");
    should_resize_element_unordered_map_int.insert_or_assign(cbCardType, "cbCardType");
    should_resize_element_unordered_map_int.insert_or_assign(cbCardType2, "cbCardType2");
    should_resize_element_unordered_map_int.insert_or_assign(stAttribute, "stAttribute");
    should_resize_element_unordered_map_int.insert_or_assign(cbAttribute, "cbAttribute");
    should_resize_element_unordered_map_int.insert_or_assign(stRace, "stRace");
    should_resize_element_unordered_map_int.insert_or_assign(cbRace, "cbRace");
    should_resize_element_unordered_map_int.insert_or_assign(stStar, "stStar");
    should_resize_element_unordered_map_int.insert_or_assign(ebStar, "ebStar");
    should_resize_element_unordered_map_int.insert_or_assign(stScale, "stScale");
    should_resize_element_unordered_map_int.insert_or_assign(ebScale, "ebScale");
    should_resize_element_unordered_map_int.insert_or_assign(btnMarksFilter, "btnMarksFilter");
    should_resize_element_unordered_map_int.insert_or_assign(stLimit, "stLimit");
    should_resize_element_unordered_map_int.insert_or_assign(cbLimit, "cbLimit");
    should_resize_element_unordered_map_int.insert_or_assign(stAttack, "stAttack");
    should_resize_element_unordered_map_int.insert_or_assign(ebAttack, "ebAttack");
    should_resize_element_unordered_map_int.insert_or_assign(stDefense, "stDefense");
    should_resize_element_unordered_map_int.insert_or_assign(ebDefense, "ebDefense");
    //~ should_resize_element_unordered_map_int.insert_or_assign(btnEffectFilter, "btnEffectFilter");
    should_resize_element_unordered_map_int.insert_or_assign(stSearch, "stSearch");
    should_resize_element_unordered_map_int.insert_or_assign(ebCardName, "ebCardName");
    should_resize_element_unordered_map_int.insert_or_assign(btnClearFilter, "btnClearFilter");
    should_resize_element_unordered_map_int.insert_or_assign(btnStartFilter, "btnStartFilter");

    should_resize_element_unordered_map_int.insert_or_assign(wDeckEdit, "wDeckEdit");
    should_resize_element_unordered_map_int.insert_or_assign(btnManageDeck, "btnManageDeck");
    should_resize_element_unordered_map_int.insert_or_assign(stDBCategory, "stDBCategory");
    should_resize_element_unordered_map_int.insert_or_assign(cbDBCategory, "cbDBCategory");
    should_resize_element_unordered_map_int.insert_or_assign(stDeck, "stDeck");
    should_resize_element_unordered_map_int.insert_or_assign(cbDBDecks, "cbDBDecks");
    should_resize_element_unordered_map_int.insert_or_assign(btnSaveDeck, "btnSaveDeck");
    should_resize_element_unordered_map_int.insert_or_assign(ebDeckname, "ebDeckname");
    should_resize_element_unordered_map_int.insert_or_assign(btnSaveDeckAs, "btnSaveDeckAs");
    should_resize_element_unordered_map_int.insert_or_assign(btnDeleteDeck, "btnDeleteDeck");
    should_resize_element_unordered_map_int.insert_or_assign(btnShuffleDeck, "btnShuffleDeck");
    should_resize_element_unordered_map_int.insert_or_assign(btnSortDeck, "btnSortDeck");
    should_resize_element_unordered_map_int.insert_or_assign(btnClearDeck, "btnClearDeck");

    should_resize_element_unordered_map_int.insert_or_assign(wSort, "wSort");
    should_resize_element_unordered_map_int.insert_or_assign(cbSortType, "cbSortType");

    should_resize_element_unordered_map_int.insert_or_assign(scrFilter, "scrFilter");

    should_resize_element_unordered_map_int.insert_or_assign(wMessage, "wMessage");
    should_resize_element_unordered_map_int.insert_or_assign(stMessage, "stMessage");
    should_resize_element_unordered_map_int.insert_or_assign(btnMsgOK, "btnMsgOK");
    should_resize_element_unordered_map_int.insert_or_assign(wACMessage, "wACMessage");
    should_resize_element_unordered_map_int.insert_or_assign(stACMessage, "stACMessage");
    should_resize_element_unordered_map_int.insert_or_assign(wQuery, "wQuery");
    should_resize_element_unordered_map_int.insert_or_assign(stQMessage, "stQMessage");
    should_resize_element_unordered_map_int.insert_or_assign(btnYes, "btnYes");
    should_resize_element_unordered_map_int.insert_or_assign(btnNo, "btnNo");
    should_resize_element_unordered_map_int.insert_or_assign(wSurrender, "wSurrender");
    should_resize_element_unordered_map_int.insert_or_assign(stSurrenderMessage, "stSurrenderMessage");
    should_resize_element_unordered_map_int.insert_or_assign(btnSurrenderYes, "btnSurrenderYes");
    should_resize_element_unordered_map_int.insert_or_assign(btnSurrenderNo, "btnSurrenderNo");

    should_resize_element_unordered_map_int.insert_or_assign(stHintMsg, "stHintMsg");

    should_resize_element_unordered_map_int.insert_or_assign(btnLeaveGame, "btnLeaveGame");
    should_resize_element_unordered_map_int.insert_or_assign(chain_timing_combo_box, "chain_timing_combo_box");
    should_resize_element_unordered_map_int.insert_or_assign(btnShuffle, "btnShuffle");
    should_resize_element_unordered_map_int.insert_or_assign(btnCancelOrFinish, "btnCancelOrFinish");

    should_resize_element_unordered_map_int.insert_or_assign(wOptions, "wOptions");
    should_resize_element_unordered_map_int.insert_or_assign(btnOptionOK, "btnOptionOK");
    should_resize_element_unordered_map_int.insert_or_assign(wOptions_combo_box_option, "wOptions_combo_box_option");

    should_resize_element_unordered_map_int.insert_or_assign(lstLog, "lstLog");
    //~ should_resize_element_unordered_map_int.insert_or_assign(btnClearLog, "btnClearLog");

    should_resize_element_unordered_map_int.insert_or_assign(static_text_search_record, "static_text_search_record");
    should_resize_element_unordered_map_int.insert_or_assign(combo_box_search_record, "combo_box_search_record");

    should_resize_element_unordered_map_int.insert_or_assign(wANAttribute, "wANAttribute");
    should_resize_element_unordered_map_int.insert_or_assign(smMessage, "smMessage");

    //~ should_resize_element_unordered_map_int.insert_or_assign($a.3, "$a.3");
    //~ cc.p
  }
} // namespace ygo
