namespace my_lua {

  void load_script(lua_State* o1, const char* o2);
  lua_State* init_lua(void);
  lua_State* init_gui_state(void);
  luabridge::LuaRef init_sound_path(void);
  //~ const char* 显示常量(int32_t o1, const char* o2);
  
  inline lua_State* gui_state = init_gui_state();
  inline luabridge::LuaRef sound_path = init_sound_path();
}
