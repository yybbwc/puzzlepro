local target_name = "libjpeg"
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
    --~ k1[#k1 + 1] = "ws2_32"
    --~ k1[#k1 + 1] = "bcrypt"
    --~ k1[#k1 + 1] = "iphlpapi"
    for i = 1, #k1 do
      add_links(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    --~ k1[#k1 + 1] = dir_path .. "include"
    --~ k1[#k1 + 1] = dir_path .. "compat"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "HAVE_CONFIG_H"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    --~ k1[#k1 + 1] = dir_path .. "evthread_win32.c"
    --~ k1[#k1 + 1] = dir_path .. "buffer.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent_filter.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent_pair.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent_ratelim.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent_sock.c"
    --~ k1[#k1 + 1] = dir_path .. "event.c"
    --~ k1[#k1 + 1] = dir_path .. "evmap.c"
    --~ k1[#k1 + 1] = dir_path .. "evthread.c"
    --~ k1[#k1 + 1] = dir_path .. "evutil.c"
    --~ k1[#k1 + 1] = dir_path .. "evutil_rand.c"
    --~ k1[#k1 + 1] = dir_path .. "evutil_time.c"
    --~ k1[#k1 + 1] = dir_path .. "watch.c"
    --~ k1[#k1 + 1] = dir_path .. "listener.c"
    --~ k1[#k1 + 1] = dir_path .. "log.c"
    --~ k1[#k1 + 1] = dir_path .. "signal.c"
    --~ k1[#k1 + 1] = dir_path .. "strlcpy.c"
    --~ k1[#k1 + 1] = dir_path .. "epoll.c"
    --~ k1[#k1 + 1] = dir_path .. "wepoll.c"
    --~ k1[#k1 + 1] = dir_path .. "buffer_iocp.c"
    --~ k1[#k1 + 1] = dir_path .. "bufferevent_async.c"
    --~ k1[#k1 + 1] = dir_path .. "event_iocp.c"
    --~ k1[#k1 + 1] = dir_path .. "win32select.c"
    --~ k1[#k1 + 1] = dir_path .. "event_tagging.c"
    --~ k1[#k1 + 1] = dir_path .. "http.c"
    --~ k1[#k1 + 1] = dir_path .. "evdns.c"
    --~ k1[#k1 + 1] = dir_path .. "ws.c"
    --~ k1[#k1 + 1] = dir_path .. "sha1.c"
    --~ k1[#k1 + 1] = dir_path .. "evrpc.c"

    k1[#k1 + 1] = dir_path .. "jaricom.c"
    k1[#k1 + 1] = dir_path .. "jcapimin.c"
    k1[#k1 + 1] = dir_path .. "jcapistd.c"
    k1[#k1 + 1] = dir_path .. "jcarith.c"
    k1[#k1 + 1] = dir_path .. "jccoefct.c"
    k1[#k1 + 1] = dir_path .. "jccolor.c"
    k1[#k1 + 1] = dir_path .. "jcdctmgr.c"
    k1[#k1 + 1] = dir_path .. "jchuff.c"
    k1[#k1 + 1] = dir_path .. "jcinit.c"
    k1[#k1 + 1] = dir_path .. "jcmainct.c"
    k1[#k1 + 1] = dir_path .. "jcmarker.c"
    k1[#k1 + 1] = dir_path .. "jcmaster.c"
    k1[#k1 + 1] = dir_path .. "jcomapi.c"
    k1[#k1 + 1] = dir_path .. "jcparam.c"
    k1[#k1 + 1] = dir_path .. "jcprepct.c"
    k1[#k1 + 1] = dir_path .. "jcsample.c"
    k1[#k1 + 1] = dir_path .. "jctrans.c"
    k1[#k1 + 1] = dir_path .. "jdapimin.c"
    k1[#k1 + 1] = dir_path .. "jdapistd.c"
    k1[#k1 + 1] = dir_path .. "jdarith.c"
    k1[#k1 + 1] = dir_path .. "jdatadst.c"
    k1[#k1 + 1] = dir_path .. "jdatasrc.c"
    k1[#k1 + 1] = dir_path .. "jdcoefct.c"
    k1[#k1 + 1] = dir_path .. "jdcolor.c"
    k1[#k1 + 1] = dir_path .. "jddctmgr.c"
    k1[#k1 + 1] = dir_path .. "jdhuff.c"
    k1[#k1 + 1] = dir_path .. "jdinput.c"
    k1[#k1 + 1] = dir_path .. "jdmainct.c"
    k1[#k1 + 1] = dir_path .. "jdmarker.c"
    k1[#k1 + 1] = dir_path .. "jdmaster.c"
    k1[#k1 + 1] = dir_path .. "jdmerge.c"
    k1[#k1 + 1] = dir_path .. "jdpostct.c"
    k1[#k1 + 1] = dir_path .. "jdsample.c"
    k1[#k1 + 1] = dir_path .. "jdtrans.c"
    k1[#k1 + 1] = dir_path .. "jerror.c"
    k1[#k1 + 1] = dir_path .. "jfdctflt.c"
    k1[#k1 + 1] = dir_path .. "jfdctfst.c"
    k1[#k1 + 1] = dir_path .. "jfdctint.c"
    k1[#k1 + 1] = dir_path .. "jidctflt.c"
    k1[#k1 + 1] = dir_path .. "jidctfst.c"
    k1[#k1 + 1] = dir_path .. "jidctint.c"
    k1[#k1 + 1] = dir_path .. "jquant1.c"
    k1[#k1 + 1] = dir_path .. "jquant2.c"
    k1[#k1 + 1] = dir_path .. "jutils.c"
    k1[#k1 + 1] = dir_path .. "jmemmgr.c"
    k1[#k1 + 1] = dir_path .. "jmemnobs.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("jconfig.h") then
    else
      do
        local k1 = {}
        k1[#k1 + 1] = "./configure"
        for i = 1, #k1 do
          os.exec(k1[i])
        end
      end
    end
  end)
end
