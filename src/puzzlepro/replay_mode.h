#pragma once

namespace ygo {

  class ReplayMode {
  public:
    static bool is_continuing;
    static bool is_closing;
    static bool is_pausing;
    static bool is_paused;
    static bool is_swaping;
    static bool is_restarting;
    static bool exit_pending;
    static int skip_turn;
    static int current_step;
    static int skip_step;
    static void ReloadLocation(int player, int location, int flag, std::vector<unsigned char> &queryBuffer);

    static bool pauseable;
    static uint8_t *pbuf;
    static uint8_t *offset;
    //~ cc.gc /[a-zA-Z_\*0-9]+/ a

    /*
    end_replay
    complete_operation
    further_judge
    cc.gc w a

    static constexpr int64_t return_value_$a.1 = #0;
    cc.p
    */

    static constexpr int64_t return_value_end_replay = 0;
    static constexpr int64_t return_value_complete_operation = 1;
    static constexpr int64_t return_value_further_judge = 2;

    static intptr_t pduel;
    static Replay cur_replay;
    static Replay tmp_replay;

    static bool StartReplay(int skipturn);
    static bool start_replay(int64_t skip_turn_);
    static void StopReplay(bool is_exiting = false);
    static void SwapField();
    static void Pause(bool is_pause, bool is_step);
    static bool ReadReplayResponse();
    static int ReplayThread();
    static bool StartDuel();
    static void EndDuel();
    static void Restart(bool refresh);
    static void Undo();
    static bool ReplayAnalyze(unsigned char *msg, unsigned int len);

    static int64_t ReplayAnalyze_(int64_t o1);
    /*
MSG_RETRY MSG_RETRY
MSG_HINT MSG_HINT
MSG_WIN MSG_WIN
MSG_SELECT_BATTLECMD MSG_SELECT_BATTLECMD
MSG_SELECT_IDLECMD MSG_SELECT_IDLECMD
MSG_SELECT_EFFECTYN MSG_SELECT_EFFECTYN
MSG_SELECT_YESNO MSG_SELECT_YESNO
MSG_SELECT_OPTION MSG_SELECT_OPTION
MSG_SELECT_CARD MSG_SELECT_CARD
MSG_SELECT_TRIBUTE MSG_SELECT_CARD
MSG_SELECT_UNSELECT_CARD MSG_SELECT_UNSELECT_CARD
MSG_SELECT_CHAIN MSG_SELECT_CHAIN
MSG_SELECT_PLACE MSG_SELECT_PLACE
MSG_SELECT_DISFIELD MSG_SELECT_PLACE
MSG_SELECT_POSITION MSG_SELECT_POSITION
MSG_SELECT_COUNTER MSG_SELECT_COUNTER
MSG_SELECT_SUM MSG_SELECT_SUM
MSG_SORT_CARD MSG_SORT_CARD
MSG_CONFIRM_DECKTOP MSG_CONFIRM_DECKTOP
MSG_CONFIRM_EXTRATOP MSG_CONFIRM_EXTRATOP
MSG_CONFIRM_CARDS MSG_CONFIRM_CARDS
MSG_SHUFFLE_DECK MSG_SHUFFLE_DECK
MSG_SHUFFLE_HAND MSG_SHUFFLE_HAND
MSG_SHUFFLE_EXTRA MSG_SHUFFLE_EXTRA
MSG_REFRESH_DECK MSG_REFRESH_DECK
MSG_SWAP_GRAVE_DECK MSG_SWAP_GRAVE_DECK
MSG_REVERSE_DECK MSG_REVERSE_DECK
MSG_DECK_TOP MSG_DECK_TOP
MSG_SHUFFLE_SET_CARD MSG_SHUFFLE_SET_CARD
MSG_NEW_TURN MSG_NEW_TURN
MSG_NEW_PHASE MSG_NEW_PHASE
MSG_MOVE MSG_MOVE
MSG_POS_CHANGE MSG_POS_CHANGE
MSG_SET MSG_SET
MSG_SWAP MSG_SWAP
MSG_FIELD_DISABLED MSG_FIELD_DISABLED
MSG_SUMMONING MSG_SUMMONING
MSG_SUMMONED MSG_SUMMONED
MSG_SPSUMMONING MSG_SPSUMMONING
MSG_SPSUMMONED MSG_SPSUMMONED
MSG_FLIPSUMMONING MSG_FLIPSUMMONING
MSG_FLIPSUMMONED MSG_FLIPSUMMONED
MSG_CHAINING MSG_CHAINING
MSG_CHAINED MSG_CHAINED
MSG_CHAIN_SOLVING MSG_CHAIN_SOLVING
MSG_CHAIN_SOLVED MSG_CHAIN_SOLVED
MSG_CHAIN_END MSG_CHAIN_END
MSG_CHAIN_NEGATED MSG_CHAIN_NEGATED
MSG_CHAIN_DISABLED MSG_CHAIN_DISABLED
MSG_CARD_SELECTED MSG_CARD_SELECTED
MSG_RANDOM_SELECTED MSG_CARD_SELECTED
MSG_BECOME_TARGET MSG_BECOME_TARGET
MSG_DRAW MSG_DRAW
MSG_DAMAGE MSG_DAMAGE
MSG_RECOVER MSG_RECOVER
MSG_EQUIP MSG_EQUIP
MSG_LPUPDATE MSG_LPUPDATE
MSG_UNEQUIP MSG_UNEQUIP
MSG_CARD_TARGET MSG_CARD_TARGET
MSG_CANCEL_TARGET MSG_CANCEL_TARGET
MSG_PAY_LPCOST MSG_PAY_LPCOST
MSG_ADD_COUNTER MSG_ADD_COUNTER
MSG_REMOVE_COUNTER MSG_REMOVE_COUNTER
MSG_ATTACK MSG_ATTACK
MSG_BATTLE MSG_BATTLE
MSG_ATTACK_DISABLED MSG_ATTACK_DISABLED
MSG_DAMAGE_STEP_START MSG_DAMAGE_STEP_START
MSG_DAMAGE_STEP_END MSG_DAMAGE_STEP_END
MSG_MISSED_EFFECT MSG_MISSED_EFFECT
MSG_TOSS_COIN MSG_TOSS_COIN
MSG_TOSS_DICE MSG_TOSS_DICE
MSG_ROCK_PAPER_SCISSORS MSG_ROCK_PAPER_SCISSORS
MSG_HAND_RES MSG_HAND_RES
MSG_ANNOUNCE_RACE MSG_ANNOUNCE_RACE
MSG_ANNOUNCE_ATTRIB MSG_ANNOUNCE_ATTRIB
MSG_ANNOUNCE_CARD MSG_ANNOUNCE_CARD
MSG_ANNOUNCE_NUMBER MSG_ANNOUNCE_CARD
MSG_CARD_HINT MSG_CARD_HINT
MSG_PLAYER_HINT MSG_PLAYER_HINT
MSG_MATCH_KILL MSG_MATCH_KILL
MSG_TAG_SWAP MSG_TAG_SWAP
MSG_RELOAD_FIELD MSG_RELOAD_FIELD
MSG_AI_NAME MSG_AI_NAME
MSG_SHOW_HINT MSG_SHOW_HINT
cc.gc w a

static int64_t ReplayAnalyze_$a.1();
cc.p
    */

    static int64_t ReplayAnalyze_MSG_RETRY();
    static int64_t ReplayAnalyze_MSG_HINT();
    static int64_t ReplayAnalyze_MSG_WIN();
    static int64_t ReplayAnalyze_MSG_SELECT_BATTLECMD();
    static int64_t ReplayAnalyze_MSG_SELECT_IDLECMD();
    static int64_t ReplayAnalyze_MSG_SELECT_EFFECTYN();
    static int64_t ReplayAnalyze_MSG_SELECT_YESNO();
    static int64_t ReplayAnalyze_MSG_SELECT_OPTION();
    static int64_t ReplayAnalyze_MSG_SELECT_CARD();
    static int64_t ReplayAnalyze_MSG_SELECT_TRIBUTE();
    static int64_t ReplayAnalyze_MSG_SELECT_UNSELECT_CARD();
    static int64_t ReplayAnalyze_MSG_SELECT_CHAIN();
    static int64_t ReplayAnalyze_MSG_SELECT_PLACE();
    static int64_t ReplayAnalyze_MSG_SELECT_DISFIELD();
    static int64_t ReplayAnalyze_MSG_SELECT_POSITION();
    static int64_t ReplayAnalyze_MSG_SELECT_COUNTER();
    static int64_t ReplayAnalyze_MSG_SELECT_SUM();
    static int64_t ReplayAnalyze_MSG_SORT_CARD();
    static int64_t ReplayAnalyze_MSG_CONFIRM_DECKTOP();
    static int64_t ReplayAnalyze_MSG_CONFIRM_EXTRATOP();
    static int64_t ReplayAnalyze_MSG_CONFIRM_CARDS();
    static int64_t ReplayAnalyze_MSG_SHUFFLE_DECK();
    static int64_t ReplayAnalyze_MSG_SHUFFLE_HAND();
    static int64_t ReplayAnalyze_MSG_SHUFFLE_EXTRA();
    static int64_t ReplayAnalyze_MSG_REFRESH_DECK();
    static int64_t ReplayAnalyze_MSG_SWAP_GRAVE_DECK();
    static int64_t ReplayAnalyze_MSG_REVERSE_DECK();
    static int64_t ReplayAnalyze_MSG_DECK_TOP();
    static int64_t ReplayAnalyze_MSG_SHUFFLE_SET_CARD();
    static int64_t ReplayAnalyze_MSG_NEW_TURN();
    static int64_t ReplayAnalyze_MSG_NEW_PHASE();
    static int64_t ReplayAnalyze_MSG_MOVE();
    static int64_t ReplayAnalyze_MSG_POS_CHANGE();
    static int64_t ReplayAnalyze_MSG_SET();
    static int64_t ReplayAnalyze_MSG_SWAP();
    static int64_t ReplayAnalyze_MSG_FIELD_DISABLED();
    static int64_t ReplayAnalyze_MSG_SUMMONING();
    static int64_t ReplayAnalyze_MSG_SUMMONED();
    static int64_t ReplayAnalyze_MSG_SPSUMMONING();
    static int64_t ReplayAnalyze_MSG_SPSUMMONED();
    static int64_t ReplayAnalyze_MSG_FLIPSUMMONING();
    static int64_t ReplayAnalyze_MSG_FLIPSUMMONED();
    static int64_t ReplayAnalyze_MSG_CHAINING();
    static int64_t ReplayAnalyze_MSG_CHAINED();
    static int64_t ReplayAnalyze_MSG_CHAIN_SOLVING();
    static int64_t ReplayAnalyze_MSG_CHAIN_SOLVED();
    static int64_t ReplayAnalyze_MSG_CHAIN_END();
    static int64_t ReplayAnalyze_MSG_CHAIN_NEGATED();
    static int64_t ReplayAnalyze_MSG_CHAIN_DISABLED();
    static int64_t ReplayAnalyze_MSG_CARD_SELECTED();
    static int64_t ReplayAnalyze_MSG_RANDOM_SELECTED();
    static int64_t ReplayAnalyze_MSG_BECOME_TARGET();
    static int64_t ReplayAnalyze_MSG_DRAW();
    static int64_t ReplayAnalyze_MSG_DAMAGE();
    static int64_t ReplayAnalyze_MSG_RECOVER();
    static int64_t ReplayAnalyze_MSG_EQUIP();
    static int64_t ReplayAnalyze_MSG_LPUPDATE();
    static int64_t ReplayAnalyze_MSG_UNEQUIP();
    static int64_t ReplayAnalyze_MSG_CARD_TARGET();
    static int64_t ReplayAnalyze_MSG_CANCEL_TARGET();
    static int64_t ReplayAnalyze_MSG_PAY_LPCOST();
    static int64_t ReplayAnalyze_MSG_ADD_COUNTER();
    static int64_t ReplayAnalyze_MSG_REMOVE_COUNTER();
    static int64_t ReplayAnalyze_MSG_ATTACK();
    static int64_t ReplayAnalyze_MSG_BATTLE();
    static int64_t ReplayAnalyze_MSG_ATTACK_DISABLED();
    static int64_t ReplayAnalyze_MSG_DAMAGE_STEP_START();
    static int64_t ReplayAnalyze_MSG_DAMAGE_STEP_END();
    static int64_t ReplayAnalyze_MSG_MISSED_EFFECT();
    static int64_t ReplayAnalyze_MSG_TOSS_COIN();
    static int64_t ReplayAnalyze_MSG_TOSS_DICE();
    static int64_t ReplayAnalyze_MSG_ROCK_PAPER_SCISSORS();
    static int64_t ReplayAnalyze_MSG_HAND_RES();
    static int64_t ReplayAnalyze_MSG_ANNOUNCE_RACE();
    static int64_t ReplayAnalyze_MSG_ANNOUNCE_ATTRIB();
    static int64_t ReplayAnalyze_MSG_ANNOUNCE_CARD();
    static int64_t ReplayAnalyze_MSG_ANNOUNCE_NUMBER();
    static int64_t ReplayAnalyze_MSG_CARD_HINT();
    static int64_t ReplayAnalyze_MSG_PLAYER_HINT();
    static int64_t ReplayAnalyze_MSG_MATCH_KILL();
    static int64_t ReplayAnalyze_MSG_TAG_SWAP();
    static int64_t ReplayAnalyze_MSG_RELOAD_FIELD();
    static int64_t ReplayAnalyze_MSG_AI_NAME();
    static int64_t ReplayAnalyze_MSG_SHOW_HINT();

    //~ static bool ReplayAnalyze_MSG_SELECT_IDLECMD(uint8_t* pbuf, uint8_t* len);

    //~ static bool ReplayAnalyze_MSG_SELECT_BATTLECMD(uint8_t* pbuf);
    //~ static bool ReplayAnalyze_MSG_SELECT_CHAIN(uint8_t* pbuf);
    //~ static bool ReplayAnalyze_MSG_SELECT_CARD(uint8_t* pbuf);
    //~ static bool ReplayAnalyze_MSG_SELECT_PLACE(uint8_t* pbuf);
    //~ static bool ReplayAnalyze_MSG_SELECT_EFFECTYN(uint8_t* pbuf);
    //~ static bool ReplayAnalyze_MSG_WIN(uint8_t* pbuf);

    static void ReplayRefresh(int flag = 0xf81fff);
    static void ReplayRefreshLocation(int player, int location, int flag);
    static void ReplayRefreshHand(int player, int flag = 0x781fff);
    static void ReplayRefreshGrave(int player, int flag = 0x181fff);
    static void ReplayRefreshDeck(int player, int flag = 0x181fff);
    static void ReplayRefreshExtra(int player, int flag = 0x181fff);
    static void ReplayRefreshSingle(int player, int location, int sequence, int flag = 0xf81fff);
    static void ReplayReload();

    static uint32_t MessageHandler(intptr_t fduel, uint32_t type);
  };

} // namespace ygo

//~ #endif // REPLAY_MODE_H
