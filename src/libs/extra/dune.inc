
(rule
  (alias fmt)
  (deps
   audio.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to audio.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/audio.liq)))
      (diff audio.liq audio.liq.prettier))))

(rule
  (alias fmt)
  (deps
   deprecations.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to deprecations.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/deprecations.liq)))
      (diff deprecations.liq deprecations.liq.prettier))))

(rule
  (alias fmt)
  (deps
   externals.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to externals.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/externals.liq)))
      (diff externals.liq externals.liq.prettier))))

(rule
  (alias fmt)
  (deps
   file.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to file.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/file.liq)))
      (diff file.liq file.liq.prettier))))

(rule
  (alias fmt)
  (deps
   gstreamer.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to gstreamer.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/gstreamer.liq)))
      (diff gstreamer.liq gstreamer.liq.prettier))))

(rule
  (alias fmt)
  (deps
   http.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to http.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/http.liq)))
      (diff http.liq http.liq.prettier))))

(rule
  (alias fmt)
  (deps
   interactive.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to interactive.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/interactive.liq)))
      (diff interactive.liq interactive.liq.prettier))))

(rule
  (alias fmt)
  (deps
   lastfm.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to lastfm.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/lastfm.liq)))
      (diff lastfm.liq lastfm.liq.prettier))))

(rule
  (alias fmt)
  (deps
   native.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to native.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/native.liq)))
      (diff native.liq native.liq.prettier))))

(rule
  (alias fmt)
  (deps
   server.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to server.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/server.liq)))
      (diff server.liq server.liq.prettier))))

(rule
  (alias fmt)
  (deps
   source.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to source.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/source.liq)))
      (diff source.liq source.liq.prettier))))

(rule
  (alias fmt)
  (deps
   telnet.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to telnet.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/telnet.liq)))
      (diff telnet.liq telnet.liq.prettier))))

(rule
  (alias fmt)
  (deps
   visualization.liq
   (source_tree ../../tooling/prettier)
   ../../tooling/json_dump.exe
   ../../tooling/prettier/node_modules
 )
  (action
    (progn
      (with-stdout-to visualization.liq.prettier
       (chdir ../../tooling/prettier
         (run pnpm prettier --config ./config.json ../../libs/extra/visualization.liq)))
      (diff visualization.liq visualization.liq.prettier))))
