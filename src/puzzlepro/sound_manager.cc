
namespace ygo {

  SoundManager soundManager;

  bool SoundManager::Init() {
    bgm_scene = -1;
    RefreshBGMList();
    rnd.reset((unsigned int)std::time(nullptr));
    ma_decoding_backend_vtable *pCustomBackendVTables[] = {ma_decoding_backend_libvorbis, ma_decoding_backend_libopus};
    resourceManagerConfig = ma_resource_manager_config_init();
    resourceManagerConfig.ppCustomDecodingBackendVTables = pCustomBackendVTables;
    resourceManagerConfig.customDecodingBackendCount = sizeof(pCustomBackendVTables) / sizeof(pCustomBackendVTables[0]);
    resourceManagerConfig.pCustomDecodingBackendUserData = NULL;
    ma_resource_manager_init(&resourceManagerConfig, &resourceManager);
    engineConfig = ma_engine_config_init();
    engineConfig.pResourceManager = &resourceManager;
    return !(ma_engine_init(&engineConfig, &engineSound) or ma_engine_init(&engineConfig, &engineMusic));
  }

  void SoundManager::RefreshBGMList() {
    RefershBGMDir(L"", BGM_DUEL);
    RefershBGMDir(L"duel", BGM_DUEL);
    RefershBGMDir(L"menu", BGM_MENU);
    RefershBGMDir(L"deck", BGM_DECK);
    RefershBGMDir(L"advantage", BGM_ADVANTAGE);
    RefershBGMDir(L"disadvantage", BGM_DISADVANTAGE);
    RefershBGMDir(L"win", BGM_WIN);
    RefershBGMDir(L"lose", BGM_LOSE);
  }

  void SoundManager::RefershBGMDir(std::wstring path, int scene) {
    std::wstring search = L"./sound/BGM/" + path;
    FileSystem::TraversalDir(search.c_str(), [this, &path, scene](const wchar_t *name, bool isdir) {
      if (!isdir && (IsExtension(name, L".mp3") || IsExtension(name, L".ogg") or IsExtension(name, L".flac") or IsExtension(name, L".wav") or IsExtension(name, L".opus"))) {
        std::wstring filename = path + L"/" + name;
        BGMList[BGM_ALL].push_back(filename);
        BGMList[scene].push_back(filename);
      }
    });
  }

  void SoundManager::PlaySoundEffect(int sound) {
    using luabridge::getGlobal;
    using luabridge::main_thread;
    auto gui_sound = getGlobal(main_thread(mainGame->get_lua(boost::this_thread::get_id())), "sound");
    if (!mainGame->chkEnableSound->isChecked()) {
      return;
    }
    ma_engine_set_volume(&engineSound, mainGame->gameConf.sound_volume);
    ma_engine_play_sound(&engineSound, gui_sound[sound], nullptr);
  }

  void SoundManager::PlayDialogSound(irr::gui::IGUIElement *element) {
    if (element == mainGame->wMessage) {
      PlaySoundEffect(SOUND_INFO);
    }
    else if (element == mainGame->wQuery) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wSurrender) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wOptions) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wANAttribute) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wANCard) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wANNumber) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wANRace) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wReplaySave) {
      PlaySoundEffect(SOUND_QUESTION);
    }
    else if (element == mainGame->wFTSelect) {
      PlaySoundEffect(SOUND_QUESTION);
    }
  }

  void SoundManager::PlayMusic(char *song, bool loop) {
    if (!mainGame->chkEnableMusic->isChecked()) {
      return;
    }
    ma_sound_uninit(&soundBGM);
    ma_sound_init_from_file_w(&engineMusic, reinterpret_cast<wchar_t *>(song), MA_SOUND_FLAG_ASYNC | MA_SOUND_FLAG_STREAM, nullptr, nullptr, &soundBGM);
    ma_sound_set_looping(&soundBGM, loop);
    ma_sound_start(&soundBGM);
  }

  void SoundManager::PlayBGM(int scene) {
    if (!mainGame->chkEnableMusic->isChecked()) {
      return;
    }
    if (!mainGame->chkMusicMode->isChecked()) {
      scene = BGM_ALL;
    }
    char BGMName[1024];
    if (scene != bgm_scene or !ma_sound_is_playing(&soundBGM)) {
      int count = BGMList[scene].size();
      if (count <= 0) {
        return;
      }
      bgm_scene = scene;
      int bgm = rnd.get_random_integer(0, count - 1);
      const auto *name = BGMList[scene][bgm].c_str();
      wchar_t fname[1024];
      myswprintf(fname, L"./sound/BGM/%ls", name);
      PlayMusic(reinterpret_cast<char *>(fname), false);
    }
  }

  void SoundManager::StopBGM() {
    ma_sound_stop(&soundBGM);
  }

  void SoundManager::SetSoundVolume(double volume) {
    ma_engine_set_volume(&engineSound, volume);
  }

  void SoundManager::SetMusicVolume(double volume) {
    ma_engine_set_volume(&engineMusic, volume);
  }
} // namespace ygo
