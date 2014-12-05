

set(command "/usr/bin/cmake;-P;/home/berocs/Documents/dotfiles/kharselim/j4-dmenu-desktop/catch/tmp/catch-gitclone.cmake")
execute_process(
  COMMAND ${command}
  RESULT_VARIABLE result
  OUTPUT_FILE "/home/berocs/Documents/dotfiles/kharselim/j4-dmenu-desktop/catch/src/catch-stamp/catch-download-out.log"
  ERROR_FILE "/home/berocs/Documents/dotfiles/kharselim/j4-dmenu-desktop/catch/src/catch-stamp/catch-download-err.log"
  )
if(result)
  set(msg "Command failed: ${result}\n")
  foreach(arg IN LISTS command)
    set(msg "${msg} '${arg}'")
  endforeach()
  set(msg "${msg}\nSee also\n  /home/berocs/Documents/dotfiles/kharselim/j4-dmenu-desktop/catch/src/catch-stamp/catch-download-*.log\n")
  message(FATAL_ERROR "${msg}")
else()
  set(msg "catch download command succeeded.  See also /home/berocs/Documents/dotfiles/kharselim/j4-dmenu-desktop/catch/src/catch-stamp/catch-download-*.log\n")
  message(STATUS "${msg}")
endif()
