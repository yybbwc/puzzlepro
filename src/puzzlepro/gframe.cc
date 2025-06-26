
unsigned int enable_log = 0x3;
bool exit_on_return = false;
bool open_file = false;
wchar_t open_file_name[512] = L"";
bool bot_mode = false;

void ClickButton(irr::gui::IGUIElement *btn) {
  irr::SEvent event;
  event.EventType = irr::EET_GUI_EVENT;
  event.GUIEvent.EventType = irr::gui::EGET_BUTTON_CLICKED;
  event.GUIEvent.Caller = btn;
  ygo::mainGame->device->postEventFromUser(event);
}

int main(int argc, char *argv[]) {
  using namespace ygo;
  WORD wVersionRequested = 0;
  WSADATA wsaData;
  wVersionRequested = MAKEWORD(2, 2);
  WSAStartup(wVersionRequested, &wsaData);
  evthread_use_windows_threads();
  Game _game;
  mainGame = &_game;
  if (!mainGame->Initialize()) {
    return 0;
  }
  ygo::mainGame->MainLoop();
  WSACleanup();
  return EXIT_SUCCESS;
}
