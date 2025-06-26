#pragma once

namespace ygo {

  class SingleMode {
  public:
    static bool StartPlay();
    static void StopPlay(bool is_exiting = false);
    static void SetResponse(unsigned char *resp, unsigned int len);
    static int SinglePlayThread();
    static bool SinglePlayAnalyze(unsigned char *msg, unsigned int len);

    static void SinglePlayRefresh(int flag = 0xf81fff);
    static void SingleRefreshLocation(int player, int location, int flag);
    static void SinglePlayRefreshHand(int player, int flag = 0x781fff);
    static void SinglePlayRefreshGrave(int player, int flag = 0x181fff);
    static void SinglePlayRefreshDeck(int player, int flag = 0x181fff);
    static void SinglePlayRefreshExtra(int player, int flag = 0x181fff);
    static void SinglePlayRefreshSingle(int player, int location, int sequence, int flag = 0xf81fff);
    static void SinglePlayReload();
    static void start_record(ReplayHeader &rh);
    static void save_replay();

    static constexpr int64_t start_lp = 8000;
    static constexpr int64_t start_hand = 5;
    static constexpr int64_t draw_count = 1;
    static fast_io::string filename;

    static uint32_t MessageHandler(intptr_t fduel, uint32_t type);

    static intptr_t pduel;
    static bool is_closing;
    static bool is_continuing;
    static void ReloadLocation(int player, int location, int flag, std::vector<unsigned char> &queryBuffer);

    static Replay last_replay;
  };

} // namespace ygo
