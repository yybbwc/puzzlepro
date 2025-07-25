
#pragma once

namespace ygo {

// replay flag
#define REPLAY_COMPRESSED 0x1
#define REPLAY_TAG 0x2
#define REPLAY_DECODED 0x4
#define REPLAY_SINGLE_MODE 0x8
#define REPLAY_UNIFORM 0x10

  // max size
  constexpr int MAX_REPLAY_SIZE = 0x40000;
  constexpr int MAX_COMP_SIZE = UINT16_MAX + 1;

  struct ReplayHeader {
    uint32_t id{};
    uint32_t version{};
    uint32_t flag{};
    int64_t seed;
    uint32_t datasize{};
    uint32_t start_time{};
    uint32_t msg_count = 0;
  };

  class Replay {

  public:
    Replay();
    ~Replay();

    // record
    void BeginRecord();
    void WriteHeader(ReplayHeader &header);
    void WriteData(const void *data, size_t length);

    template <typename T> void Write(T data) {
      WriteData(&data, sizeof(T));
      this->pheader.msg_count = this->pheader.msg_count + 1;
    }

    void EndRecord();
    void SaveReplay(const wchar_t *name);

    // play
    bool OpenReplay(const wchar_t *name);
    bool ReadNextResponse(unsigned char resp[]);
    bool ReadName(wchar_t *data);
    void ReadHeader(ReplayHeader &header);
    bool ReadData(void *data, size_t length);

    template <typename T> T Read() {
      T ret{};
      ReadData(&ret, sizeof(T));
      return ret;
    }

    void Rewind();

    FILE *fp{nullptr};
    HANDLE recording_fp{nullptr};

    ReplayHeader pheader;
    unsigned char *comp_data;
    size_t comp_size{};

  private:
    unsigned char *replay_data;
    size_t replay_size{};
    size_t data_position{};
    bool is_recording{};
    bool is_replaying{};
  };

} // namespace ygo

//~ #endif
