local config = require("gui/config")
local tablex = require("pl/tablex")
local d = {}

do
  local last = ""
  d.gap = 5
  d.center_x = 1024 / 2
  d.center_y = 640 / 2
  d.new_xy = function(o1, o2, o3, o4, o5)
    d[o1] = tablex.copy(d[last] or {})
    d[o1].x1 = o2 or d[o1].x1
    d[o1].y1 = o3 or d[o1].y1
    d[o1].x2 = o4 or d[o1].x2
    d[o1].y2 = o5 or d[o1].y2
    d[o1].x1 = math.floor(d[o1].x1)
    d[o1].y1 = math.floor(d[o1].y1)
    d[o1].x2 = math.floor(d[o1].x2)
    d[o1].y2 = math.floor(d[o1].y2)
    d[o1].width = d[o1].x2 - d[o1].x1
    d[o1].height = d[o1].y2 - d[o1].y1
    d[o1].width_offset = d[o1].width + d.gap
    d[o1].height_offset = d[o1].height + d.gap
    d[o1].width_reduce = d[o1].width - d.gap
    d[o1].height_reduce = d[o1].height - d.gap
    d[o1].x1_next = d[o1].x1 + d[o1].width_offset
    d[o1].y1_next = d[o1].y1 + d[o1].height_offset
    d[o1].x2_next = d[o1].x2 + d[o1].width_offset
    d[o1].y2_next = d[o1].y2 + d[o1].height_offset
    d[o1].x1_reduce = d[o1].x1 - d.gap
    d[o1].y1_reduce = d[o1].y1 - d.gap
    d[o1].x2_reduce = d[o1].x2 - d.gap
    d[o1].y2_reduce = d[o1].y2 - d.gap
    d[o1].x1_offset = d[o1].x1 + d.gap
    d[o1].y1_offset = d[o1].y1 + d.gap
    d[o1].x2_offset = d[o1].x2 + d.gap
    d[o1].y2_offset = d[o1].y2 + d.gap
    d.x1 = d[o1].x1
    d.y1 = d[o1].y1
    d.x2 = d[o1].x2
    d.y2 = d[o1].y2
    d.x1_next = d[o1].x1_next
    d.y1_next = d[o1].y1_next
    d.x2_next = d[o1].x2_next
    d.y2_next = d[o1].y2_next
    d.x1_offset = d[o1].x1_offset
    d.y1_offset = d[o1].y1_offset
    d.x2_offset = d[o1].x2_offset
    d.y2_offset = d[o1].y2_offset
    d.width = d[o1].width
    d.height = d[o1].height
    last = o1
  end
end

d.new_xy("0", 0, 0, 0, 0)

d.new_xy("stCardPos", 30, 30, 150, 50)
d.new_xy("btnCardSelect", d.stCardPos.x1, d.stCardPos.y1_next, d.stCardPos.x2, 225)
d.new_xy("chkRace", 10, 25, 100, 50)

d.new_xy("wMainMenu", 370, 200, 650, 415)--
d.new_xy("btnLanMode", 10, 30, d.wMainMenu.width - 10, 60)
d.new_xy("btnSingleMode", nil, d.btnLanMode.y1_next, nil, d.btnLanMode.y2_next)
d.new_xy("btnReplayMode", nil, d.btnSingleMode.y1_next, nil, d.btnSingleMode.y2_next)
d.new_xy("btnDeckEdit", nil, d.btnReplayMode.y1_next, nil, d.btnReplayMode.y2_next)
d.new_xy("btnModeExit", nil, d.btnDeckEdit.y1_next, nil, d.btnDeckEdit.y2_next)
--~ cc.gc w a

d.new_xy("wMessage", 490, 200, 840, 340)
d.new_xy("stMessage", 20, 20, 350, 100)
d.new_xy("btnMsgOK", 130, 105, 220, 130)
d.new_xy("wACMessage", 490, 240, 840, 300)
d.new_xy("stACMessage", 0, 0, 350, 60)
d.new_xy("wQuery", 490, 200, 840, 340)
d.new_xy("stQMessage", 20, 20, 350, 100)
d.new_xy("btnYes", 100, 105, 150, 130)
d.new_xy("btnNo", 200, 105, 250, 130)
d.new_xy("wSurrender", 490, 200, 840, 340)
d.new_xy("stSurrenderMessage", 20, 20, 350, 100)
d.new_xy("btnSurrenderYes", 100, 105, 150, 130)
d.new_xy("btnSurrenderNo", 200, 105, 250, 130)
--~ cc.gc w a

d.new_xy("wSinglePlay", 220, 100, 800, 520)
d.new_xy("wSingle", 0, 20, 579, 419)
d.new_xy("lstBotList", 10, 10, 350, 350)
d.new_xy("btnStartBot", 459, 301, 569, 326)
d.new_xy("btnBotCancel", 459, 331, 569, 356)
d.new_xy("stBotTip", 360, 10, 550, 30)
d.new_xy("stBotInfo", 360, 40, 560, 160)
d.new_xy("cbBotDeckCategory", 360, 95, 560, 120)
d.new_xy("cbBotDeck", 360, 130, 560, 155)
d.new_xy("cbBotRule", 360, 165, 560, 190)
d.new_xy("chkBotHand", 360, 200, 560, 220)
d.new_xy("chkBotNoCheckDeck", 360, 230, 560, 250)
d.new_xy("chkBotNoShuffleDeck", 360, 260, 560, 280)
d.new_xy("single_file_select_panel", 10, 10, 350, 350)
d.new_xy("btnLoadSinglePlay", 459, 301, 569, 326)
d.new_xy("btnSinglePlayCancel", 459, 331, 569, 356)
d.new_xy("stSinglePlayTip", 360, 10, 550, 30)
d.new_xy("stSinglePlayInfo", 360, 40, 560, 160)
d.new_xy("chkSinglePlayReturnDeckTop", 360, 260, 560, 280)
--~ cc.gc w a


d.new_xy("wPhase", 480, 310, 855, 330)
d.new_xy("btnBP", 160, 0, 210, 20)
d.new_xy("btnM2", 160, 0, 210, 20)
d.new_xy("btnEP", 320, 0, 370, 20)
--~ cc.gc w a

d.new_xy("stHintMsg", 500, 60, 820, 90)

d.new_xy("btnLeaveGame", 205, 5, 300, 80)
d.new_xy("duel_sidebar_window", nil, 100, nil, 280)
d.new_xy("duel_sidebar", 0, 0, d.width, d.height)
--~ d.new_xy("chain_timing_combo_box", d.gap, d.gap, d.width - d.gap, 40)
d.new_xy("chain_timing_combo_box", 0, 0, d.width - d.gap, 35)
d.new_xy("duel_log_button", nil, d.y1_next, nil, d.y2_next)
d.new_xy("btnCancelOrFinish", nil, d.y1_next, nil, d.y2_next)
d.new_xy("btnShuffle", nil, d.y1_next, nil, d.y2_next)

d.new_xy("duel_log_window", d.center_x - 100, d.center_y - 210, d.center_x + 200, d.center_y + 100)
d.new_xy("lstLog", d.gap, 30, d.width - d.gap, d.height - 40)
d.new_xy("btnClearLog", d.x2 - 80, d.y1_next, nil, d.y1_next + 20)


--~ d.new_xy("btnShuffle", 205, 230, 295, 265)
--~ cc.gc w a

d.new_xy("wReplayControl", 205, 118, 295, 273)
d.new_xy("btnReplayStart", 5, 5, 85, 25)
d.new_xy("btnReplayPause", 5, 30, 85, 50)
d.new_xy("btnReplayStep", 5, 55, 85, 75)
d.new_xy("btnReplayUndo", 5, 80, 85, 100)
d.new_xy("btnReplaySwap", 5, 105, 85, 125)
d.new_xy("btnReplayExit", 5, 130, 85, 150)
--~ cc.gc w a

d.new_xy("wReplaySave", 510, 200, 820, 320)
d.new_xy("stReplaySave", 20, 25, 290, 45)
d.new_xy("ebRSName", 20, 50, 290, 70)
--~ d.new_xy("btnRSYes", 70, 80, 140, 105)
d.new_xy("btnRSNo", 170, 80, 240, 105)
d.new_xy("wPosSelect", 340, 200, 935, 410)
d.new_xy("btnPSAU", 30, 25, 150, 195)
d.new_xy("btnPSAD", d.btnPSAU.x1_next, d.btnPSAU.y1, d.btnPSAU.x2_next, d.btnPSAU.y2)
d.new_xy("btnPSDU", d.btnPSAD.x1_next, d.btnPSAU.y1 + 25, d.btnPSAD.x1_next + 170, d.btnPSAU.y1 + 120 + 25)
d.new_xy("btnPSDD", d.btnPSDU.x1_next, d.btnPSAU.y1 + 25, d.btnPSDU.x1_next + 170, d.btnPSAU.y1 + 120 + 25)
d.new_xy("wCardSelect", 320, 100, 1000, 400)
d.new_xy("scrCardList", d.stCardPos.x1, 235, 650, 255)
d.new_xy("btnSelectOK", 300, 265, 380, 290)
--~ cc.gc w a

d.new_xy("scrFilter", 1020 - config.scrollbar_witdh, 160, 1020, 635)

d.new_xy("smMessage", d.center_x - 250, d.center_y - 150, d.center_x + 250, d.center_y + 150)

d.new_xy("wReplay", 220, 100, 800, 520)
d.new_xy("lstReplayList", 10, 30, 350, 400)
d.new_xy("stReplayTip", 360, 30, 570, 50)
d.new_xy("stReplayInfo", nil, d.y1_next, nil, 160)
d.new_xy("replay_file_select_panel", 10, 30, 350, 400)
d.new_xy("replay_panel", d.stReplayInfo.x1, d.stReplayInfo.y2, d.stReplayInfo.x2, 410)
d.new_xy("stReplayTurnTip", 0, 0, d.replay_panel.width - 25, 25)
d.new_xy("ebRepStartTurn", d.stReplayTurnTip.x1, d.stReplayTurnTip.y1_next, d.stReplayTurnTip.x2, d.stReplayTurnTip.y2_next)
d.new_xy("btnLoadReplay", d.ebRepStartTurn.x1, d.ebRepStartTurn.y1_next, d.ebRepStartTurn.x2, d.ebRepStartTurn.y2_next)
d.new_xy("btnReplayCancel", nil, d.btnLoadReplay.y1_next, nil, d.btnLoadReplay.y2_next)
d.new_xy("btnExportDeck", nil, d.btnReplayCancel.y1_next, nil, d.btnReplayCancel.y2_next)
d.new_xy("check_single_replay_button", nil, d.y1_next, nil, d.y2_next)
d.new_xy("check_single_layer_replay_button", nil, d.check_single_replay_button.y1_next, nil, d.check_single_replay_button.y2_next)
d.new_xy("check_multi_layer_replay_button", nil, d.check_single_layer_replay_button.y1_next, nil, d.check_single_layer_replay_button.y2_next)
--~ d.new_xy("solve_puzzle_button", nil, d.check_multi_layer_replay_button.y1_next, nil, d.check_multi_layer_replay_button.y2_next)
d.new_xy("as_puzzle_button", nil, d.y1_next, nil, d.y2_next)
--~ cc.gc w a

d.new_xy("check_replay_window", 100, 100, 950, 620)
d.new_xy("check_replay_static_text", 10, 25, d.check_replay_window.width - 10, 40)
d.new_xy("check_replay_table", nil, d.y1_next, nil, d.check_replay_window.height - 10)

d.new_xy("solve_puzzle_window", 300, 300, 600, 600)
d.new_xy("solve_puzzle_table", 15, 30, d.solve_puzzle_window.width - 15, d.solve_puzzle_window.height - 15)
--~ cc.gc w a


d.new_xy("wANRace", 480, 200, 850, 410)--

d.new_xy("imgCard", 5, 5, 200, 280)
--~ d.new_xy("wCardImg", 5, 5, 200, 280)
--~ d.new_xy("imgCard", 0, 0, d.width, d.height)
--~ cc.gc w a

--~ d.new_xy("wInfos", 5, d.wCardImg.y1_next, 300, 635)
d.new_xy("wInfos", 5, d.y1_next, 300, 635)
d.new_xy("stDataInfo", 5, 5, 290, 5)
d.new_xy("stText", 5, 315, 290, 315)





--~ cc.gc w a

d.new_xy("wDeckEdit", 310, 5, 605, 130)
d.new_xy("btnManageDeck", 225, 5, 290, 30)
d.new_xy("stDBCategory", 10, 9, 100, 29)
d.new_xy("cbDBCategory", 80, 5, 220, 30)
d.new_xy("stDeck", 10, 39, 100, 59)
d.new_xy("cbDBDecks", 80, 35, 220, 60)
d.new_xy("btnSaveDeck", 225, 35, 290, 60)
d.new_xy("ebDeckname", 80, 65, 220, 90)
d.new_xy("btnSaveDeckAs", 225, 65, 290, 90)
d.new_xy("btnDeleteDeck", 225, 95, 290, 120)
d.new_xy("btnShuffleDeck", 5, 99, 55, 120)
d.new_xy("btnSortDeck", 60, 99, 110, 120)
d.new_xy("btnClearDeck", 115, 99, 165, 120)
--~ cc.gc w a

d.new_xy("wSort", 930, 132, 1020, 156)
d.new_xy("cbSortType", 10, 2, 85, 22)
--~ cc.gc w a

d.new_xy("wFilter", d.wDeckEdit.x1_next, d.wDeckEdit.y1, 1020, d.wDeckEdit.y2)

d.new_xy("stCategory", d.gap, d.gap, 40, 24)
d.new_xy("cbCardType", d.x1_next, nil, 120, nil)
d.new_xy("cbCardType2", d.x1_next, nil, 195, nil)
d.new_xy("stLimit", d.cbCardType2.x1_next, nil, d.cbCardType2.x1_next + d.stCategory.width, nil)
d.new_xy("cbLimit", d.x1_next, nil, d.wFilter.width - d.gap, nil)

d.new_xy("stAttribute", d.stCategory.x1, d.y1_next, d.stCategory.x2, d.y2_next)
d.new_xy("cbAttribute", d.x1_next, nil, d.cbCardType2.x2, nil)
d.new_xy("stAttack", d.stLimit.x1, nil, d.stLimit.x2, nil)
d.new_xy("ebAttack", d.x1_next, nil, d.x1_next + 55, nil)
d.new_xy("stDefense", d.x1_next, nil, d.x1_next + 35, nil)
d.new_xy("ebDefense", d.x1_next, nil, d.cbLimit.x2, nil)

d.new_xy("stRace", d.stCategory.x1, d.y1_next, d.stCategory.x2, d.y2_next)
d.new_xy("cbRace", d.x1_next, nil, d.cbCardType2.x2, nil)
d.new_xy("stStar", d.stAttack.x1, nil, d.stAttack.x2, nil)
d.new_xy("ebStar", d.x1_next, nil, d.ebAttack.x2, nil)
d.new_xy("stScale", d.x1_next, nil, d.stDefense.x2, nil)
d.new_xy("ebScale", d.x1_next, nil, d.ebDefense.x2, nil)

d.new_xy("static_text_search_record", d.stCategory.x1, d.y1_next, d.stCategory.x2, d.y2_next)
d.new_xy("combo_box_search_record", d.x1_next, nil, d.cbCardType2.x2, nil)
d.new_xy("stSearch", d.stLimit.x1, nil, d.stLimit.x2, nil)
d.new_xy("ebCardName", d.cbLimit.x1, nil, d.cbLimit.x2, nil)

d.new_xy("btnMarksFilter", d.cbCardType.x1, d.y1_next, d.cbCardType2.x2, d.y2_next)
d.new_xy("btnClearFilter", d.stLimit.x1, nil, d.stLimit.x2, nil)
d.new_xy("btnStartFilter", d.cbLimit.x1, nil, d.cbLimit.x2, nil)

d.new_xy("wANAttribute", 500, 200, 830, 285)
d.new_xy("chkAttribute", 10, 25, 80, 45)
--~ cc.gc w a

d.new_xy("btnEffectFilter", 0,0.0,0)
--~ cc.gc w a


d.new_xy("system_setting_tab", d.gap, d.gap, 290, 315)
d.new_xy("chkIgnore1", d.gap, d.gap, d.system_setting_tab.width_offset - 20, 25)
d.new_xy("chkIgnore2", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkHidePlayerName", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkIgnoreDeckChanges", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkAutoSearch", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkMultiKeywords", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkPreferExpansionScript", nil, d.y1_next, nil, d.y2_next)
d.new_xy("static_text_window_size", nil, d.y1_next, nil, d.y2_next)
d.new_xy("btnWinResizeS", nil, d.y1_next, d.width / 4, d.y2_next)
d.new_xy("btnWinResizeM", d.x1_next, nil, d.x2_next, nil)
d.new_xy("btnWinResizeL", d.x1_next, nil, d.x2_next, nil)
d.new_xy("btnWinResizeXL", d.x1_next, nil, d.x2_next, nil)
d.new_xy("chkLFlist", d.static_text_window_size.x1, d.y1_next, d.static_text_window_size.x2, d.y2_next)
d.new_xy("cbLFlist", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkEnableSound", nil, d.y1_next, nil, d.y2_next)
d.new_xy("scrSoundVolume", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkEnableMusic", nil, d.y1_next, nil, d.y2_next)
d.new_xy("scrMusicVolume", nil, d.y1_next, nil, d.y2_next)
d.new_xy("chkMusicMode", nil, d.y1_next, nil, d.y2_next)

d.new_xy("wANNumber", d.center_x - 150, d.center_y - 45, d.center_x + 150, d.center_y + 45)
d.new_xy("cbANNumber", d.gap, 25, d.wANNumber.width_reduce, 50)
d.new_xy("btnANNumberOK", nil, d.y1_next, nil, d.y2_next)

d.new_xy("gradient_background_main_deck", d.wDeckEdit.x1, d.scrFilter.y1, 800, 436)
d.new_xy("gradient_background_main_deck_pack", nil, nil, nil, d.scrFilter.y2)
d.new_xy("gradient_background_extra_deck", nil, 462, nil, 535)
d.new_xy("gradient_background_side_deck", nil, 560, nil, d.scrFilter.y2)

d.deck_edit_search_result_show_number = 7
d.new_xy("gradient_background_search_result", 805, d.scrFilter.y1, d.scrFilter.x2, d.scrFilter.y2)
--~ d.new_xy("deck_edit_search_result_image", d.x1_offset - 300, nil, d.gradient_background_search_result.x1 + 50, d.y1 + d.height / d.deck_edit_search_result_show_number + 1)
d.new_xy("deck_edit_search_result_image", nil, nil, d.gradient_background_search_result.x1 + 45, d.y1 + d.height / d.deck_edit_search_result_show_number)
d.new_xy("deck_edit_search_result_text_row_1", d.x1_next, d.y1_offset, d.gradient_background_search_result.x2, d.y1_offset + 15)
d.new_xy("deck_edit_search_result_text_row_2", nil, d.y1_next, nil, d.y2_next)
d.new_xy("deck_edit_search_result_text_row_3", nil, d.y1_next, nil, d.y2_next)
--~ cc.gc /[^\(",\)]+/ a

d.gradient_background_main_deck.x1_adjust = d.gradient_background_main_deck.x1 + 3
d.gradient_background_main_deck.y1_adjust = d.gradient_background_main_deck.y1 + 4
d.gradient_background_main_deck.width_adjust = d.gradient_background_main_deck.width - 3
d.gradient_background_main_deck.height_adjust = d.gradient_background_main_deck.height - 7

d.gradient_background_extra_deck.x1_adjust = d.gradient_background_extra_deck.x1 + 3
d.gradient_background_extra_deck.y1_adjust = d.gradient_background_extra_deck.y1 + 3

d.gradient_background_side_deck.x1_adjust = d.gradient_background_side_deck.x1 + 3
d.gradient_background_side_deck.y1_adjust = d.gradient_background_side_deck.y1 + 4

d.new_xy("wOptions", 490, 200, 840, 310)
d.new_xy("wOptions_combo_box_option", 10, 30, d.wOptions.width - 10, 60)
d.new_xy("btnOptionOK", nil, d.y1_next, nil, d.y2_next)
--~ cc.gc w a

return d
