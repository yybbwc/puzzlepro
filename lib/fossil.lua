local target_name = "fossil"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
local translate_path = "translate_c/"
local xmake_mod_path = os.projectdir() .. "/xmake/mod/"
target(target_name)
do
  set_kind("binary")
  add_deps("zlib", "openssl", "fossil_makeheaders")
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/"
    k1[#k1 + 1] = dir_path .. "extsrc/"
    k1[#k1 + 1] = dir_path .. translate_path
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "FOSSIL_ENABLE_SSL=1"
    k1[#k1 + 1] = "BROKEN_MINGW_CMDLINE=1"
    for i = 1, #k1 do
      add_defines(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "extsrc/pikchr.c"
    k1[#k1 + 1] = dir_path .. "extsrc/cson_amalgamation.c"
    k1[#k1 + 1] = dir_path .. "src/th.c"
    k1[#k1 + 1] = dir_path .. "src/th_lang.c"
    k1[#k1 + 1] = dir_path .. "src/th_tcl.c"
    k1[#k1 + 1] = dir_path .. "win/fossil.rc"
    k1[#k1 + 1] = dir_path .. translate_path .. "*.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = "SQLITE_MAX_EXPR_DEPTH=0"
    k1[#k1 + 1] = "SQLITE_DQS=0"
    k1[#k1 + 1] = "SQLITE_THREADSAFE=0"
    k1[#k1 + 1] = "SQLITE_DEFAULT_MEMSTATUS=0"
    k1[#k1 + 1] = "SQLITE_DEFAULT_WAL_SYNCHRONOUS=1"
    k1[#k1 + 1] = "SQLITE_LIKE_DOESNT_MATCH_BLOBS"
    k1[#k1 + 1] = "SQLITE_OMIT_DECLTYPE"
    k1[#k1 + 1] = "SQLITE_OMIT_DEPRECATED"
    k1[#k1 + 1] = "SQLITE_OMIT_PROGRESS_CALLBACK"
    k1[#k1 + 1] = "SQLITE_OMIT_SHARED_CACHE"
    k1[#k1 + 1] = "SQLITE_OMIT_LOAD_EXTENSION"
    k1[#k1 + 1] = "SQLITE_DEFAULT_FILE_FORMAT=4"
    k1[#k1 + 1] = "SQLITE_ENABLE_DBSTAT_VTAB"
    k1[#k1 + 1] = "SQLITE_ENABLE_EXPLAIN_COMMENTS"
    k1[#k1 + 1] = "SQLITE_ENABLE_FTS4"
    k1[#k1 + 1] = "SQLITE_ENABLE_FTS5"
    k1[#k1 + 1] = "SQLITE_ENABLE_MATH_FUNCTIONS"
    k1[#k1 + 1] = "SQLITE_ENABLE_STMTVTAB"
    k1[#k1 + 1] = "SQLITE_ENABLE_DBPAGE_VTAB"
    k1[#k1 + 1] = "SQLITE_HAVE_ZLIB"
    k1[#k1 + 1] = "HAVE_USLEEP"
    k1[#k1 + 1] = "SQLITE_TRUSTED_SCHEMA=0"
    k1[#k1 + 1] = "SQLITE_WIN32_NO_ANSI"
    k1[#k1 + 1] = "_HAVE__MINGW_H"
    k1[#k1 + 1] = "SQLITE_USE_MALLOC_H"
    k1[#k1 + 1] = "SQLITE_USE_MSIZE"
    add_files(dir_path .. "extsrc/sqlite3.c", { defines = k1 })
    local k2 = {}
    table.join2(k2, k1)
    k2[#k2 + 1] = "main=sqlite3_shell"
    k2[#k2 + 1] = "SQLITE_SHELL_IS_UTF8=1"
    k2[#k2 + 1] = "SQLITE_SHELL_DBNAME_PROC=sqlcmd_get_dbname"
    k2[#k2 + 1] = "SQLITE_SHELL_INIT_PROC=sqlcmd_init_proc"
    k2[#k2 + 1] = "access=file_access"
    k2[#k2 + 1] = "system=fossil_system"
    k2[#k2 + 1] = "getenv=fossil_getenv"
    k2[#k2 + 1] = "fopen=fossil_fopen"
    add_files(dir_path .. "extsrc/shell.c", { defines = k2 })
  end
end
do
  local target_name = "fossil_translate"
  target(target_name)
  do
    set_kind("binary")
    do
      local k1 = {}
      k1[#k1 + 1] = dir_path .. "tools/translate.c"
      for i = 1, #k1 do
        add_files(k1[i])
      end
    end
    after_build(function(target)
      import("my", { rootdir = xmake_mod_path })
      os.cd(dir_path)
      if os.exists(translate_path) then
      else
        local k1 = {}
        k1[#k1 + 1] = dir_path .. "src/add.c"
        k1[#k1 + 1] = dir_path .. "src/ajax.c"
        k1[#k1 + 1] = dir_path .. "src/alerts.c"
        k1[#k1 + 1] = dir_path .. "src/allrepo.c"
        k1[#k1 + 1] = dir_path .. "src/attach.c"
        k1[#k1 + 1] = dir_path .. "src/backlink.c"
        k1[#k1 + 1] = dir_path .. "src/backoffice.c"
        k1[#k1 + 1] = dir_path .. "src/bag.c"
        k1[#k1 + 1] = dir_path .. "src/bisect.c"
        k1[#k1 + 1] = dir_path .. "src/blob.c"
        k1[#k1 + 1] = dir_path .. "src/branch.c"
        k1[#k1 + 1] = dir_path .. "src/browse.c"
        k1[#k1 + 1] = dir_path .. "src/builtin.c"
        k1[#k1 + 1] = dir_path .. "src/bundle.c"
        k1[#k1 + 1] = dir_path .. "src/cache.c"
        k1[#k1 + 1] = dir_path .. "src/capabilities.c"
        k1[#k1 + 1] = dir_path .. "src/captcha.c"
        k1[#k1 + 1] = dir_path .. "src/cgi.c"
        k1[#k1 + 1] = dir_path .. "src/chat.c"
        k1[#k1 + 1] = dir_path .. "src/checkin.c"
        k1[#k1 + 1] = dir_path .. "src/checkout.c"
        k1[#k1 + 1] = dir_path .. "src/clearsign.c"
        k1[#k1 + 1] = dir_path .. "src/clone.c"
        k1[#k1 + 1] = dir_path .. "src/color.c"
        k1[#k1 + 1] = dir_path .. "src/comformat.c"
        k1[#k1 + 1] = dir_path .. "src/configure.c"
        k1[#k1 + 1] = dir_path .. "src/content.c"
        k1[#k1 + 1] = dir_path .. "src/cookies.c"
        k1[#k1 + 1] = dir_path .. "src/db.c"
        k1[#k1 + 1] = dir_path .. "src/delta.c"
        k1[#k1 + 1] = dir_path .. "src/deltacmd.c"
        k1[#k1 + 1] = dir_path .. "src/deltafunc.c"
        k1[#k1 + 1] = dir_path .. "src/descendants.c"
        k1[#k1 + 1] = dir_path .. "src/diff.c"
        k1[#k1 + 1] = dir_path .. "src/diffcmd.c"
        k1[#k1 + 1] = dir_path .. "src/dispatch.c"
        k1[#k1 + 1] = dir_path .. "src/doc.c"
        k1[#k1 + 1] = dir_path .. "src/encode.c"
        k1[#k1 + 1] = dir_path .. "src/etag.c"
        k1[#k1 + 1] = dir_path .. "src/event.c"
        k1[#k1 + 1] = dir_path .. "src/export.c"
        k1[#k1 + 1] = dir_path .. "src/extcgi.c"
        k1[#k1 + 1] = dir_path .. "src/file.c"
        k1[#k1 + 1] = dir_path .. "src/fileedit.c"
        k1[#k1 + 1] = dir_path .. "src/finfo.c"
        k1[#k1 + 1] = dir_path .. "src/foci.c"
        k1[#k1 + 1] = dir_path .. "src/forum.c"
        k1[#k1 + 1] = dir_path .. "src/fshell.c"
        k1[#k1 + 1] = dir_path .. "src/fusefs.c"
        k1[#k1 + 1] = dir_path .. "src/fuzz.c"
        k1[#k1 + 1] = dir_path .. "src/glob.c"
        k1[#k1 + 1] = dir_path .. "src/graph.c"
        k1[#k1 + 1] = dir_path .. "src/gzip.c"
        k1[#k1 + 1] = dir_path .. "src/hname.c"
        k1[#k1 + 1] = dir_path .. "src/hook.c"
        k1[#k1 + 1] = dir_path .. "src/http.c"
        k1[#k1 + 1] = dir_path .. "src/http_socket.c"
        k1[#k1 + 1] = dir_path .. "src/http_ssl.c"
        k1[#k1 + 1] = dir_path .. "src/http_transport.c"
        k1[#k1 + 1] = dir_path .. "src/import.c"
        k1[#k1 + 1] = dir_path .. "src/info.c"
        k1[#k1 + 1] = dir_path .. "src/interwiki.c"
        k1[#k1 + 1] = dir_path .. "src/json.c"
        k1[#k1 + 1] = dir_path .. "src/json_artifact.c"
        k1[#k1 + 1] = dir_path .. "src/json_branch.c"
        k1[#k1 + 1] = dir_path .. "src/json_config.c"
        k1[#k1 + 1] = dir_path .. "src/json_diff.c"
        k1[#k1 + 1] = dir_path .. "src/json_dir.c"
        k1[#k1 + 1] = dir_path .. "src/json_finfo.c"
        k1[#k1 + 1] = dir_path .. "src/json_login.c"
        k1[#k1 + 1] = dir_path .. "src/json_query.c"
        k1[#k1 + 1] = dir_path .. "src/json_report.c"
        k1[#k1 + 1] = dir_path .. "src/json_status.c"
        k1[#k1 + 1] = dir_path .. "src/json_tag.c"
        k1[#k1 + 1] = dir_path .. "src/json_timeline.c"
        k1[#k1 + 1] = dir_path .. "src/json_user.c"
        k1[#k1 + 1] = dir_path .. "src/json_wiki.c"
        k1[#k1 + 1] = dir_path .. "src/leaf.c"
        k1[#k1 + 1] = dir_path .. "src/loadctrl.c"
        k1[#k1 + 1] = dir_path .. "src/login.c"
        k1[#k1 + 1] = dir_path .. "src/lookslike.c"
        k1[#k1 + 1] = dir_path .. "src/main.c"
        k1[#k1 + 1] = dir_path .. "src/manifest.c"
        k1[#k1 + 1] = dir_path .. "src/markdown.c"
        k1[#k1 + 1] = dir_path .. "src/markdown_html.c"
        k1[#k1 + 1] = dir_path .. "src/match.c"
        k1[#k1 + 1] = dir_path .. "src/md5.c"
        k1[#k1 + 1] = dir_path .. "src/merge.c"
        k1[#k1 + 1] = dir_path .. "src/merge3.c"
        k1[#k1 + 1] = dir_path .. "src/moderate.c"
        k1[#k1 + 1] = dir_path .. "src/name.c"
        k1[#k1 + 1] = dir_path .. "src/patch.c"
        k1[#k1 + 1] = dir_path .. "src/path.c"
        k1[#k1 + 1] = dir_path .. "src/piechart.c"
        k1[#k1 + 1] = dir_path .. "src/pikchrshow.c"
        k1[#k1 + 1] = dir_path .. "src/pivot.c"
        k1[#k1 + 1] = dir_path .. "src/popen.c"
        k1[#k1 + 1] = dir_path .. "src/pqueue.c"
        k1[#k1 + 1] = dir_path .. "src/printf.c"
        k1[#k1 + 1] = dir_path .. "src/publish.c"
        k1[#k1 + 1] = dir_path .. "src/purge.c"
        k1[#k1 + 1] = dir_path .. "src/rebuild.c"
        k1[#k1 + 1] = dir_path .. "src/regexp.c"
        k1[#k1 + 1] = dir_path .. "src/repolist.c"
        k1[#k1 + 1] = dir_path .. "src/report.c"
        k1[#k1 + 1] = dir_path .. "src/rss.c"
        k1[#k1 + 1] = dir_path .. "src/schema.c"
        k1[#k1 + 1] = dir_path .. "src/search.c"
        k1[#k1 + 1] = dir_path .. "src/security_audit.c"
        k1[#k1 + 1] = dir_path .. "src/setup.c"
        k1[#k1 + 1] = dir_path .. "src/setupuser.c"
        k1[#k1 + 1] = dir_path .. "src/sha1.c"
        k1[#k1 + 1] = dir_path .. "src/sha1hard.c"
        k1[#k1 + 1] = dir_path .. "src/sha3.c"
        k1[#k1 + 1] = dir_path .. "src/shun.c"
        k1[#k1 + 1] = dir_path .. "src/sitemap.c"
        k1[#k1 + 1] = dir_path .. "src/skins.c"
        k1[#k1 + 1] = dir_path .. "src/smtp.c"
        k1[#k1 + 1] = dir_path .. "src/sqlcmd.c"
        k1[#k1 + 1] = dir_path .. "src/stash.c"
        k1[#k1 + 1] = dir_path .. "src/stat.c"
        k1[#k1 + 1] = dir_path .. "src/statrep.c"
        k1[#k1 + 1] = dir_path .. "src/style.c"
        k1[#k1 + 1] = dir_path .. "src/sync.c"
        k1[#k1 + 1] = dir_path .. "src/tag.c"
        k1[#k1 + 1] = dir_path .. "src/tar.c"
        k1[#k1 + 1] = dir_path .. "src/terminal.c"
        k1[#k1 + 1] = dir_path .. "src/th_main.c"
        k1[#k1 + 1] = dir_path .. "src/timeline.c"
        k1[#k1 + 1] = dir_path .. "src/tkt.c"
        k1[#k1 + 1] = dir_path .. "src/tktsetup.c"
        k1[#k1 + 1] = dir_path .. "src/undo.c"
        k1[#k1 + 1] = dir_path .. "src/unicode.c"
        k1[#k1 + 1] = dir_path .. "src/unversioned.c"
        k1[#k1 + 1] = dir_path .. "src/update.c"
        k1[#k1 + 1] = dir_path .. "src/url.c"
        k1[#k1 + 1] = dir_path .. "src/user.c"
        k1[#k1 + 1] = dir_path .. "src/utf8.c"
        k1[#k1 + 1] = dir_path .. "src/util.c"
        k1[#k1 + 1] = dir_path .. "src/verify.c"
        k1[#k1 + 1] = dir_path .. "src/vfile.c"
        k1[#k1 + 1] = dir_path .. "src/wiki.c"
        k1[#k1 + 1] = dir_path .. "src/wikiformat.c"
        k1[#k1 + 1] = dir_path .. "src/winfile.c"
        k1[#k1 + 1] = dir_path .. "src/winhttp.c"
        k1[#k1 + 1] = dir_path .. "src/xfer.c"
        k1[#k1 + 1] = dir_path .. "src/xfersetup.c"
        k1[#k1 + 1] = dir_path .. "src/zip.c"
        os.mkdir(translate_path)
        local k2 = target:targetfile() .. " "
        for i1, i2 in ipairs(my.files(k1)) do
          local k3 = k2 .. i2
          print(k3)
          local k4 = os.iorunv(k3)
          local k5 = translate_path .. string.match(i2, "[^\\]+$")
          io.writefile(k5, k4)
        end
      end
    end)
  end
end
do
  local target_name = "fossil_mkindex"
  target(target_name)
  do
    set_kind("binary")
    add_deps("fossil_translate")
    do
      local k1 = {}
      k1[#k1 + 1] = dir_path .. "tools/mkindex.c"
      for i = 1, #k1 do
        add_files(k1[i])
      end
    end
    after_build(function(target)
      os.cd(dir_path)
      local k201 = translate_path .. "page_index.h"
      if os.exists(k201) then
      else
        local k1 = target:targetfile() .. " "
        local k2 = ""
        local k101 = translate_path .. "*.c"
        for i1, i2 in ipairs(os.files(k101)) do
          k2 = k2 .. i2 .. " "
        end
        local k3 = k1 .. k2
        print(k3)
        local k4 = os.iorunv(k3)
        io.writefile(k201, k4)
      end
    end)
  end
end
do
  local target_name = "fossil_mkbuiltin"
  target(target_name)
  do
    set_kind("binary")
    add_deps("fossil_mkindex")
    do
      local k1 = {}
      k1[#k1 + 1] = dir_path .. "tools/mkbuiltin.c"
      for i = 1, #k1 do
        add_files(k1[i])
      end
    end
    after_build(function(target)
      os.cd(dir_path)
      import("my", { rootdir = xmake_mod_path })
      local k201 = translate_path .. "builtin_data.h"
      if os.exists(k201) then
      else
        local k1 = target:targetfile() .. " --prefix src/ "
        local k2 = ""
        do
          local k102 = {}
          k102[#k102 + 1] = "extsrc/*.js"
          k102[#k102 + 1] = "extsrc/*.wasm"
          k102[#k102 + 1] = "skins/**.txt"
          k102[#k102 + 1] = "src/*.js"
          k102[#k102 + 1] = "src/**.wav"
          k102[#k102 + 1] = "src/*.css"
          k102[#k102 + 1] = "src/*.wiki"
          k102[#k102 + 1] = "src/*.tcl"
          k102[#k102 + 1] = "src/*.md"
          for i1, i2 in ipairs(my.files(k102)) do
            local k3 = string.gsub(i2, [[\]], "/")
            local k4 = ""
            if string.match(k3, "^src/") then
              k4 = k3
            else
              k4 = "src/../" .. k3
            end
            k2 = k2 .. k4 .. " "
          end
        end
        local k3 = k1 .. k2
        print(k3)
        local k4 = os.iorunv(k3)
        io.writefile(k201, k4)
      end
    end)
  end
end
do
  local target_name = "fossil_mkversion"
  target(target_name)
  do
    set_kind("binary")
    add_deps("fossil_mkbuiltin")
    do
      local k1 = {}
      k1[#k1 + 1] = dir_path .. "tools/mkversion.c"
      for i = 1, #k1 do
        add_files(k1[i])
      end
    end
    after_build(function(target)
      os.cd(dir_path)
      local k101 = translate_path .. "VERSION.h"
      if os.exists(k101) then
      else
        local k1 = target:targetfile() .. " manifest.uuid manifest VERSION"
        print(k1)
        local k3 = os.iorunv(k1)
        io.writefile(k101, k3)
      end
    end)
  end
end
do
  local target_name = "fossil_makeheaders"
  target(target_name)
  do
    set_kind("binary")
    add_deps("fossil_mkversion")
    do
      local k1 = {}
      k1[#k1 + 1] = dir_path .. "tools/makeheaders.c"
      for i = 1, #k1 do
        add_files(k1[i])
      end
    end
    after_build(function(target)
      os.cd(dir_path)
      import("my", { rootdir = xmake_mod_path })
      local k201 = translate_path .. "db.h"
      if os.exists(k201) then
      else
        local k1 = target:targetfile() .. " extsrc/sqlite3.h extsrc/pikchr.c src/th.h " .. translate_path .. "VERSION.h "
        local k2 = ""
        do
          local k101 = {}
          k101[#k101 + 1] = translate_path .. "*.c"
          for i1, i2 in ipairs(my.files(k101)) do
            k2 = k2 .. i2 .. " "
          end
        end
        local k3 = k1 .. k2
        print(k3)
        os.exec(k3)
      end
    end)
  end
end
