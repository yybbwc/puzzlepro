
namespace ygo {

  Replay::Replay() : replay_data(new unsigned char[MAX_REPLAY_SIZE]), comp_data(new unsigned char[MAX_COMP_SIZE]) {
  }

  Replay::~Replay() {
    delete[] replay_data;
    delete[] comp_data;
  }

  void Replay::BeginRecord() {
    using fast_io::wconcat_std;
    using fast_io::mnp::code_cvt;
    using FileSystem::IsDirExists;
    using FileSystem::MakeDir;
    using luabridge::getGlobal;
    using luabridge::main_thread;

    auto gui_config = getGlobal(main_thread(mainGame->get_lua(boost::this_thread::get_id())), "config");
    auto replay_dir = wconcat_std(code_cvt(gui_config["replay_dir"].tostring()));
    auto replay_file_suffix = wconcat_std(L".", code_cvt(gui_config["replay_file_suffix"].tostring()));

    if (!IsDirExists(replay_dir.c_str()) && !MakeDir(replay_dir.c_str())) {
      return;
    }
    if (is_recording) {
      CloseHandle(recording_fp);
    }
    replay_dir.append(L"_last_replay");
    replay_dir.append(replay_file_suffix);
    recording_fp = CreateFileW(replay_dir.c_str(), GENERIC_WRITE, 0, nullptr, CREATE_ALWAYS, FILE_FLAG_WRITE_THROUGH, nullptr);
    if (recording_fp == INVALID_HANDLE_VALUE) {
      return;
    }
    replay_size = 0;
    comp_size = 0;
    is_replaying = false;
    is_recording = true;
  }

  void Replay::WriteHeader(ReplayHeader &header) {
    pheader = header;
    DWORD size = 0;
    WriteFile(recording_fp, &header, sizeof(header), &size, nullptr);
  }

  void Replay::WriteData(const void *data, size_t length) {
    if (!is_recording) {
      return;
    }
    if (replay_size + length > MAX_REPLAY_SIZE) {
      return;
    }

    //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    std::memcpy(replay_data + replay_size, data, length);
    replay_size += length;
    DWORD size = 0;
    WriteFile(recording_fp, data, length, &size, nullptr);
  }

  void Replay::EndRecord() {
    if (!is_recording) {
      return;
    }
    CloseHandle(recording_fp);
    pheader.datasize = replay_size;
    pheader.flag |= REPLAY_COMPRESSED;
    //~ size_t propsize = 5;
    comp_size = ZSTD_compress(comp_data, MAX_COMP_SIZE, replay_data, replay_size, ZSTD_CLEVEL_DEFAULT);
    if (ZSTD_isError(comp_size)) {
      size_t error_code = comp_size;
      std::memcpy(comp_data, &error_code, sizeof error_code);
      comp_size = sizeof error_code;
    }
    is_recording = false;
  }

  void Replay::SaveReplay(const wchar_t *name) {
    using boost::this_thread::get_id;
    using fast_io::at_fdcwd;
    using fast_io::concat_std;
    using fast_io::native_mkdirat;
    using fast_io::obuf_file;
    using fast_io::mnp::code_cvt_os_c_str;
    using fast_io::operations::write_all_bytes;
    using luabridge::getGlobal;
    using luabridge::main_thread;
    using std::byte;

    auto gui_config = getGlobal(main_thread(mainGame->get_lua(get_id())), "config");
    auto replay_dir = gui_config["replay_dir"].tostring();
    auto replay_file_suffix = gui_config["replay_file_suffix"].tostring();

    native_mkdirat(at_fdcwd(), replay_dir);
    obuf_file of(concat_std(replay_dir, code_cvt_os_c_str(name), ".", replay_file_suffix));
    write_all_bytes(of, reinterpret_cast<const byte *>(__builtin_addressof(pheader)), reinterpret_cast<const byte *>(__builtin_addressof(pheader) + 1));
    write_all_bytes(of, reinterpret_cast<const byte *>(comp_data), reinterpret_cast<const byte *>(comp_data + comp_size));
  }

  bool Replay::OpenReplay(const wchar_t *name) {
    auto gui_config = luabridge::getGlobal(luabridge::main_thread(mainGame->get_lua(boost::this_thread::get_id())), "config");
    using fast_io::concat_std;
    using fast_io::wconcat_std;
    using fast_io::mnp::code_cvt;
    using fast_io::mnp::code_cvt_os_c_str;
    FILE *rfp = mywfopen(name, "rb");
    //~ mainGame->replay_relate_single_script_path = concat_std(code_cvt_os_c_str(name));
    //~ if (!rfp) {
    //~ wchar_t fname[256];
    //~ auto str = wconcat_std(code_cvt_os_c_str(gui_config["replay_dir"].tostring().c_str()), L"%ls");
    //~ mainGame->replay_relate_single_script_path = concat_std(code_cvt(str));
    //~ myswprintf(fname, str.c_str(), name);
    //~ rfp = mywfopen(fname, "rb");
    //~ }
    if (!rfp) {
      return false;
    }
    data_position = 0;
    is_recording = false;
    is_replaying = false;
    replay_size = 0;
    comp_size = 0;
    if (std::fread(&pheader, sizeof pheader, 1, rfp) < 1) {
      std::fclose(rfp);
      return false;
    }
    if (pheader.flag & REPLAY_COMPRESSED) {
      comp_size = std::fread(comp_data, 1, MAX_COMP_SIZE, rfp);
      std::fclose(rfp);
      if (pheader.datasize > MAX_REPLAY_SIZE) {
        return false;
      }
      replay_size = pheader.datasize;
      size_t decompressed_size = ZSTD_decompress(replay_data, replay_size, comp_data, comp_size);
      if (ZSTD_isError(decompressed_size) || decompressed_size != pheader.datasize) {
        replay_size = 0;
        return false;
      }
    }
    else {
      replay_size = std::fread(replay_data, 1, MAX_REPLAY_SIZE, rfp);
      std::fclose(rfp);
      comp_size = 0;
    }
    is_replaying = true;
    return true;
  }

  bool Replay::ReadNextResponse(unsigned char resp[]) {
    int64_t len;
    if (!ReadData(&len, 1) or len == 0 or !ReadData(resp, len)) {
      mainGame->check_replay_success = false;
      mainGame->replay_finished = true;
      return false;
    }
    if (mainGame->as_puzzle_should and !mainGame->replay_finished) {
      SingleMode::last_replay.Write<uint8_t>(len);
      SingleMode::last_replay.WriteData(resp, len);
    }
    return true;
  }

  bool Replay::ReadName(wchar_t *data) {
    uint16_t buffer[20]{};
    if (!ReadData(buffer, sizeof buffer)) {
      return false;
    }
    BufferIO::CopyWStr(buffer, data, 20);
    return true;
  }

  void Replay::ReadHeader(ReplayHeader &header) {
    header = pheader;
  }

  bool Replay::ReadData(void *data, size_t length) {
    if (!is_replaying) {
      return false;
    }
    if (data_position + length > replay_size) {
      is_replaying = false;
      return false;
    }
    if (length) {
      std::memcpy(data, &replay_data[data_position], length);
    }
    data_position += length;
    return true;
  }

  void Replay::Rewind() {
    data_position = 0;
  }

} // namespace ygo
