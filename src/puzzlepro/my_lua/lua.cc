lua_State* my_lua::init_lua(void) {
  lua_State* k1 = luaL_newstate();
  luaL_openlibs(k1);
  luaL_requiref(k1, "字符集转换器", luaopen_字符集转换器, 1);
  lua_pop(k1, 1);
  return k1;
}

void my_lua::load_script(lua_State* o1, const char* o2) {
  luaL_loadfile(o1, o2);
  lua_call(o1, 0, 0);
}

lua_State* my_lua::init_gui_state(void) {
  gui_state = init_lua();
  load_script(gui_state, "./lua/main.lua");
  return gui_state;
}
  
luabridge::LuaRef my_lua::init_sound_path(void) {
  return luabridge::getGlobal(gui_state, "sound_path");
}
