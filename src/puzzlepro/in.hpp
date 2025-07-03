
extern "C" {
  #include "lua.h"
  #include "lualib.h"
  #include "lauxlib.h"
  LUAMOD_API int luaopen_字符集转换器(lua_State *L);
}
#include <queue>
#if not defined(NDEBUG)
#include "slowstacktrace.h"
#endif

#include <LuaBridge/LuaBridge.h>
//~ #include "./my_lua/lua.h"
#include <miniaudio_libvorbis.h>
#include <miniaudio_libopus.h>

#include <string>
#include "fast_io.h"
#include <fast_io_device.h>
#include <fast_io_dsal/string.h>
#include <fast_io_driver/timer.h>
//~ #include <fast_io_dsal/vector.h>
//~ #include <fast_io_dsal/queue.h>

//boost
#include <boost/algorithm/string_regex.hpp>
#include <boost/algorithm/cxx11/none_of.hpp>
#include <boost/container/deque.hpp>
#include <boost/container/flat_set.hpp>
#include <boost/container/flat_map.hpp>
#include <boost/math/constants/constants.hpp>
#include <boost/spirit/home/x3.hpp>
#include <boost/thread.hpp>
#include <boost/circular_buffer.hpp>
#include <boost/range/adaptors.hpp>
#include <boost/range/algorithm.hpp>
#include <boost/filesystem.hpp>

#include <boost/serialization/serialization.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/vector.hpp>
#include <boost/serialization/export.hpp>

#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>


#include <fmt/format.h>



#include <zstd.h>

#define NOMINMAX
#include <WinSock2.h>
#include <windows.h>
#include <ws2tcpip.h>
#include <cstdio>
#include <stdlib.h>
#include <iostream>
#include <algorithm>

#include <cstdint>
#include <cwchar>
#include "../ocgcore/buffer.h"
#include "bufferio.h"

#include <vector>
#include "replay.h"

#include "../ocgcore/ocgapi.h"
#include <irrlicht.h>
#include <CGUIEnvironment.h>
#include <CGUIScrollText.h>
#include <CGUIScrollMessage.h>
#include "file_list.h"
#include <CGUIFileSelectPanel.h>
#include <CGUIEnvironment.h>
#include "config.h"

#include <GL/gl.h>
#include <GL/glu.h>
#include "CGUIImageButton.h"
#include "CGUITTFont.h"

#include <mutex>
#include <condition_variable>
#include "mysignal.h"

#include "../ocgcore/mtrandom.h"
#include <set>
#include <map>
#include "client_field.h"

#include <unordered_map>

#include <sqlite3.h>
#include "../ocgcore/card_data.h"
#include "data_manager.h"
#include "deck_manager.h"

#include "deck_con.h"

#include "menu_handler.h"
#include <ctime>
#include <list>
#include <functional>

#include <unordered_set>

#include "CGUIPanel.h"

#include "game.h"

#include <event2/thread.h>
#include <locale.h>
#include <memory>

#include "myfilesystem.h"

#include "network.h"
//~ #include "netserver.h"

#include "duelclient.h"

#include <sstream>

#include "replay_mode.h"
#include <thread>

#include "single_mode.h"


#include "image_manager.h"

#include "spmemvfs.h"

#include "client_card.h"
#include "materials.h"

#include <math.h>

#include <stack>

//~ #include "single_duel.h"

//~ #include "tag_duel.h"

#include "clip.h"
#include "miniaudio.h"
#include "sound_manager.h"
