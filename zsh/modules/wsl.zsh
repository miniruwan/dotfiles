if [[ $platform != 'wsl' ]]; then
    return
fi

# Changing git program depending on the location
# https://github.com/microsoft/WSL/issues/981#issuecomment-357328988
git() {
    if [ "${PWD:0:5}" = "/mnt/" ]; then
      /mnt/c/Program\ Files/Git/bin/git.exe "$@"
    else
      /usr/bin/git "$@"
    fi
}

# Some plugins seems not working with windows subsystem for linux.
# See https://github.com/Microsoft/BashOnWindows/issues/1887
unsetopt BG_NICE

# Make X11 Forwarding working in WSL
# https://stackoverflow.com/a/61110604
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0

alias open=explorer.exe
export PATH=$CONFIG_DIR/bin:$PATH


command_not_found_handler() {
  if cmd.exe /c "(where $1 || (help $1 |findstr /V Try)) >nul 2>nul && ($* || exit 0)"; then
      return $?
  else
      [[ -x /usr/lib/command-not-found ]] || return 1
      /usr/lib/command-not-found --no-failure-msg -- ${1+"$1"} && :
  fi
}

