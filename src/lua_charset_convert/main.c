//~ #include <lua.h>//lua_State
//~ #include <lauxlib.h>//luaL_checklstring
//~ #include <windows.h>//MultiByteToWideChar

//~ static int 把非utf16转换为utf16(lua_State *L) {
  //~ LPSTR k1 = (LPSTR)luaL_checklstring(L, 1, NULL);
  //~ UINT k2 = (UINT)luaL_checkinteger(L, 2);
  //~ size_t k3 = MultiByteToWideChar(k2, 0, k1, -1, NULL, 0);
  //~ if (k3 == 0) {
    //~ return luaL_error(L, "把非utf16转换为utf16的过程中出现了错误");
  //~ }
  //~ size_t k4 = k3 * sizeof(WCHAR);
  //~ wchar_t k5[k4];
  //~ MultiByteToWideChar(k2, 0, k1, -1, k5, k3);
  //~ lua_pushlstring(L, (const char *)k5, k4);
  //~ return 1;
//~ }

//~ static int 把utf16转换为非utf16(lua_State *L) {
  //~ LPWSTR k1 = (LPWSTR)luaL_checklstring(L, 1, NULL);
  //~ UINT k2 = (UINT)luaL_checkinteger(L, 2);
  //~ size_t k3 = WideCharToMultiByte(k2, 0, k1, -1, NULL, 0, NULL, NULL);
  //~ if (k3 == 0) {
    //~ return luaL_error(L, "把utf16转换为非utf16的过程中出现了错误");
  //~ }
  //~ char k4[k3];
  //~ WideCharToMultiByte(k2, 0, k1, -1, k4, k3, NULL, NULL);
  //~ lua_pushlstring(L, k4, k3);
  //~ return 1;
//~ }

//~ LUAMOD_API int luaopen_字符集转换器(lua_State *L) {
  //~ luaL_Reg l[] = {
    //~ { "把非utf16转换为utf16", 把非utf16转换为utf16 },
    //~ { "把utf16转换为非utf16", 把utf16转换为非utf16 },
    //~ { NULL, NULL },
  //~ };
  //~ luaL_newlib(L, l);
  //~ return 1;
//~ }


#include <lua.h>
#include <lauxlib.h>
#include <windows.h>

static int mb_to_wide(lua_State *L) {
    size_t len;
    const char *src = luaL_checklstring(L, 1, &len);
    UINT codepage = (UINT)luaL_checkinteger(L, 2);
    
    // 计算所需缓冲区大小（包括null终止符）
    int wlen = MultiByteToWideChar(codepage, 0, src, (int)len, NULL, 0);
    if (wlen == 0) {
        return luaL_error(L, "MultiByteToWideChar failed with error %d", GetLastError());
    }
    
    // 分配缓冲区（堆分配更安全）
    wchar_t *wbuff = (wchar_t *)lua_newuserdatauv(L, wlen * sizeof(wchar_t), 0);
    
    // 执行转换
    if (MultiByteToWideChar(codepage, 0, src, (int)len, wbuff, wlen) == 0) {
        return luaL_error(L, "MultiByteToWideChar failed with error %d", GetLastError());
    }
    
    lua_pushlstring(L, (const char *)wbuff, wlen * sizeof(wchar_t));
    return 1;
}

static int wide_to_mb(lua_State *L) {
    size_t len;
    const wchar_t *src = (const wchar_t *)luaL_checklstring(L, 1, &len);
    UINT codepage = (UINT)luaL_checkinteger(L, 2);
    
    // 计算所需缓冲区大小（包括null终止符）
    len /= sizeof(wchar_t); // 转换为字符数
    int mlen = WideCharToMultiByte(codepage, 0, src, (int)len, NULL, 0, NULL, NULL);
    if (mlen == 0) {
        return luaL_error(L, "WideCharToMultiByte failed with error %d", GetLastError());
    }
    
    // 分配缓冲区（堆分配更安全）
    char *mbuff = (char *)lua_newuserdatauv(L, mlen, 0);
    
    // 执行转换
    if (WideCharToMultiByte(codepage, 0, src, (int)len, mbuff, mlen, NULL, NULL) == 0) {
        return luaL_error(L, "WideCharToMultiByte failed with error %d", GetLastError());
    }
    
    lua_pushlstring(L, mbuff, mlen);
    return 1;
}

static const luaL_Reg charset_convert[] = {
    {"mb_to_wide", mb_to_wide},
    {"wide_to_mb", wide_to_mb},
    {NULL, NULL}
};

LUAMOD_API int luaopen_lua_charset_convert(lua_State *L) {
    luaL_newlib(L, charset_convert);
    return 1;
}
