local target_name = "libevent"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    --~ k1[#k1 + 1] = "LITTLE_ENDIAN"
    for i = 1, #k1 do
      add_deps(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "ws2_32"
    k1[#k1 + 1] = "bcrypt"
    k1[#k1 + 1] = "iphlpapi"
    for i = 1, #k1 do
      add_links(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include"
    k1[#k1 + 1] = dir_path .. "compat"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "LITTLE_ENDIAN"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "evthread_win32.c"
    k1[#k1 + 1] = dir_path .. "buffer.c"
    k1[#k1 + 1] = dir_path .. "bufferevent.c"
    k1[#k1 + 1] = dir_path .. "bufferevent_filter.c"
    k1[#k1 + 1] = dir_path .. "bufferevent_pair.c"
    k1[#k1 + 1] = dir_path .. "bufferevent_ratelim.c"
    k1[#k1 + 1] = dir_path .. "bufferevent_sock.c"
    k1[#k1 + 1] = dir_path .. "event.c"
    k1[#k1 + 1] = dir_path .. "evmap.c"
    k1[#k1 + 1] = dir_path .. "evthread.c"
    k1[#k1 + 1] = dir_path .. "evutil.c"
    k1[#k1 + 1] = dir_path .. "evutil_rand.c"
    k1[#k1 + 1] = dir_path .. "evutil_time.c"
    k1[#k1 + 1] = dir_path .. "watch.c"
    k1[#k1 + 1] = dir_path .. "listener.c"
    k1[#k1 + 1] = dir_path .. "log.c"
    k1[#k1 + 1] = dir_path .. "signal.c"
    k1[#k1 + 1] = dir_path .. "strlcpy.c"
    k1[#k1 + 1] = dir_path .. "epoll.c"
    k1[#k1 + 1] = dir_path .. "wepoll.c"
    k1[#k1 + 1] = dir_path .. "buffer_iocp.c"
    k1[#k1 + 1] = dir_path .. "bufferevent_async.c"
    k1[#k1 + 1] = dir_path .. "event_iocp.c"
    k1[#k1 + 1] = dir_path .. "win32select.c"
    k1[#k1 + 1] = dir_path .. "event_tagging.c"
    k1[#k1 + 1] = dir_path .. "http.c"
    k1[#k1 + 1] = dir_path .. "evdns.c"
    k1[#k1 + 1] = dir_path .. "ws.c"
    k1[#k1 + 1] = dir_path .. "sha1.c"
    k1[#k1 + 1] = dir_path .. "evrpc.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
end
