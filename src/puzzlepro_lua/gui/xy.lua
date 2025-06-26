local config = require("gui/config")
local tablex = require("pl/tablex")
local d = {}

do
  local last = ""
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
    d[o1].width_offset = d[o1].width + 5
    d[o1].height_offset = d[o1].height + 5
    d[o1].width_reduce = d[o1].width - 5
    d[o1].height_reduce = d[o1].height - 5
    d[o1].x1_next = d[o1].x1 + d[o1].width_offset
    d[o1].y1_next = d[o1].y1 + d[o1].height_offset
    d[o1].x2_next = d[o1].x2 + d[o1].width_offset
    d[o1].y2_next = d[o1].y2 + d[o1].height_offset
    d[o1].x1_reduce = d[o1].x1 - 5
    d[o1].y1_reduce = d[o1].y1 - 5
    d[o1].x2_reduce = d[o1].x2 - 5
    d[o1].y2_reduce = d[o1].y2 - 5
    d[o1].x1_offset = d[o1].x1 + 5
    d[o1].y1_offset = d[o1].y1 + 5
    d[o1].x2_offset = d[o1].x2 + 5
    d[o1].y2_offset = d[o1].y2 + 5
    d.x1_next = d[o1].x1_next
    d.y1_next = d[o1].y1_next
    d.x2_next = d[o1].x2_next
    d.y2_next = d[o1].y2_next
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

d.new_xy("btnLeaveGame", 205, 5, 295, 80)
d.new_xy("chain_timing_combo_box", 205, 100, 295, 135)
d.new_xy("btnShuffle", 205, 230, 295, 265)
d.new_xy("btnCancelOrFinish", 205, 230, 295, 265)
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

d.new_xy("smMessage", 490, 200, 840, 340) --------------------

d.new_xy("wReplay", 220, 100, 800, 520)
d.new_xy("lstReplayList", 10, 30, 350, 400)
d.new_xy("stReplayTip", 360, 30, 570, 50)
d.new_xy("stReplayInfo", d.stReplayTip.x1, d.stReplayTip.y1_next, d.stReplayTip.x2, 150)
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
d.new_xy("solve_puzzle_button", nil, d.check_multi_layer_replay_button.y1_next, nil, d.check_multi_layer_replay_button.y2_next)
d.new_xy("as_puzzle_button", nil, d.solve_puzzle_button.y1_next, nil, d.solve_puzzle_button.y2_next)
--~ cc.gc w a

d.new_xy("check_replay_window", 100, 100, 950, 620)
d.new_xy("check_replay_table", 15, 30, d.check_replay_window.width - 15, d.check_replay_window.height - 15)

d.new_xy("solve_puzzle_window", 300, 300, 600, 600)
d.new_xy("solve_puzzle_table", 15, 30, d.solve_puzzle_window.width - 15, d.solve_puzzle_window.height - 15)
--~ cc.gc w a


d.new_xy("wANRace", 480, 200, 850, 410)--

d.new_xy("wCardImg", 5, 5, 200, 280)
d.new_xy("imgCard", 0, 0, d.wCardImg.width, d.wCardImg.height)
--~ cc.gc w a

d.new_xy("wInfos", 5, d.wCardImg.y1_next, 300, 635)
d.new_xy("stDataInfo", 5, 5, 290, 5)
d.new_xy("stText", 5, 315, 290, 310)
d.new_xy("lstLog", 5, 5, 290, 290)
d.new_xy("btnClearLog", 160, 300, 260, 325)
d.new_xy("system_setting_tab", math.floor(d.wInfos.width * 1 / 43), 2, math.floor(d.wInfos.width * 42 / 43), d.wInfos.height - 42)
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


d.new_xy("wFilter", 610, 5, 1020, 130)
d.new_xy("stCategory", 10, 2 + 25 / 6, 70, 22 + 25 / 6)
d.new_xy("cbCardType", 60, 25 / 6, 120, 20 + 25 / 6)
d.new_xy("cbCardType2", 125, 25 / 6, 195, 20 + 25 / 6)
d.new_xy("stAttribute", 10, 22 + 50 / 6, 70, 42 + 50 / 6)
d.new_xy("cbAttribute", 60, 20 + 50 / 6, 195, 40 + 50 / 6)
d.new_xy("stRace", 10, 42 + 75 / 6, 70, 62 + 75 / 6)
d.new_xy("cbRace", 60, 40 + 75 / 6, 195, 60 + 75 / 6)
d.new_xy("stStar", 10, 62 + 100 / 6, 80, 82 + 100 / 6)
d.new_xy("ebStar", 60, 60 + 100 / 6, 100, 80 + 100 / 6)
d.new_xy("stScale", 101, 62 + 100 / 6, 150, 82 + 100 / 6)
d.new_xy("ebScale", 150, 60 + 100 / 6, 195, 80 + 100 / 6)
d.new_xy("btnMarksFilter", 60, 80 + 125 / 6, 195, 100 + 125 / 6)
d.new_xy("stLimit", 205, 2 + 25 / 6, 280, 22 + 25 / 6)
d.new_xy("cbLimit", 260, 25 / 6, d.wFilter.width - 5, 20 + 25 / 6)
d.new_xy("btnEffectFilter", 345, 20 + 50 / 6, nil, 60 + 75 / 6)
d.new_xy("ebCardName", 260, 60 + 100 / 6, nil, 80 + 100 / 6)
d.new_xy("btnStartFilter", 260, 80 + 125 / 6, nil, 100 + 125 / 6)
d.new_xy("stAttack", 205, 22 + 50 / 6, 280, 42 + 50 / 6)
d.new_xy("ebAttack", 260, 20 + 50 / 6, 340, 40 + 50 / 6)
d.new_xy("stDefense", 205, 42 + 75 / 6, 280, 62 + 75 / 6)
d.new_xy("ebDefense", 260, 40 + 75 / 6, 340, 60 + 75 / 6)
d.new_xy("stSearch", 205, 62 + 100 / 6, 280, 82 + 100 / 6)
d.new_xy("btnClearFilter", 205, 80 + 125 / 6, 255, 100 + 125 / 6)
--~ cc.gc w a

d.new_xy("gradient_background_main_deck", d.wDeckEdit.x1, d.scrFilter.y1, 800, 436)
d.new_xy("gradient_background_main_deck_pack", nil, nil, nil, d.scrFilter.y2)
d.new_xy("gradient_background_extra_deck", nil, 463, nil, 533)
d.new_xy("gradient_background_side_deck", nil, 560, nil, d.scrFilter.y2)
d.new_xy("gradient_background_search_result", 805, d.scrFilter.y1, d.scrFilter.x2, d.scrFilter.y2)
--~ cc.gc /[^\(",\)]+/ a

d.gradient_background_main_deck.adjust_x1_offset = d.gradient_background_main_deck.x1 + 3
d.gradient_background_main_deck.x1_adjust = d.gradient_background_main_deck.x1 + 3
d.gradient_background_main_deck.x1_adjust_adjust = d.gradient_background_main_deck.x1_adjust - 2
d.gradient_background_main_deck.x1_adjust_adjust_adjust = d.gradient_background_main_deck.x1_adjust_adjust - 3
d.gradient_background_main_deck.adjust_x2_offset = d.gradient_background_main_deck.x2_offset - 10
d.gradient_background_main_deck.adjust_x1_offset_reduce = d.gradient_background_main_deck.adjust_x1_offset - 1
d.gradient_background_main_deck.adjust_y1_offset = d.gradient_background_main_deck.y1 + 3
d.gradient_background_main_deck.y1_adjust = d.gradient_background_main_deck.y1 + 3
d.gradient_background_main_deck.y1_adjust_adjust = d.gradient_background_main_deck.y1_adjust - 1
d.gradient_background_main_deck.y1_adjust_adjust_adjust = d.gradient_background_main_deck.y1_adjust_adjust - 3
d.gradient_background_main_deck.adjust_y1_offset_reduce = d.gradient_background_main_deck.adjust_y1_offset - 1
d.gradient_background_main_deck.adjust_x1_reduce = d.gradient_background_main_deck.x1 - 2
d.gradient_background_main_deck.height_adjust = d.gradient_background_main_deck.height - 7

d.gradient_background_main_deck.adjust_width_reduce = d.gradient_background_main_deck.width_reduce - 2
d.gradient_background_main_deck.adjust_height_reduce = d.gradient_background_main_deck.height_reduce - 2

d.new_xy("wOptions", 490, 200, 840, 310)
d.new_xy("wOptions_combo_box_option", 10, 30, d.wOptions.width - 10, 60)
d.new_xy("btnOptionOK", nil, d.y1_next, nil, d.y2_next)
--~ cc.gc w a

return d
