#!/bin/bash

# Exit on error
set -e

configure_cmake() {
  if [[ $platform != 'linux' ]]; then
    print_important "Installing cmake is currently implemented only linux"
    return 1;
  fi

  local programName=cmake
  local minimumRequriredVersion=3
  if [[ -x "$(command -v $programName)" ]]; then # program exists
    local availableVersion=$($programName --version | head -n 1 | cut -d" " -f 3)
    if [[ $availableVersion -gt $minimumRequriredVersion ]]; then
      print_debug "Compilation is not required for $programName because the available version($availableVersion) \
        already satisfies the minimumRequriredVersion($minimumRequriredVersion)"
      return 0;
    else
      print_debug "Compiling $programName because because the available version($availableVersion) \
        is less than the minimumRequriredVersion($minimumRequriredVersion)"
    fi
  else
    print_debug "Compiling $programName because $programName is not found"
  fi

  cmakeLatestVersion=$(curl --silent "https://api.github.com/repos/Kitware/CMake/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | cut -d'v' -f 2)
  cd ~/packages
  wget https://github.com/Kitware/CMake/releases/download/v$cmakeLatestVersion/cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
  tar -xzvf cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
  cd cmake-$cmakeLatestVersion-Linux-x86_64
  # install
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/
  cp -r bin/* ~/.local/bin/
  cp -r share/* ~/.local/share/

  # cleanup
  cd ~/packages
  rm -rf cmake-$cmakeLatestVersion-Linux-x86_64
  rm cmake-$cmakeLatestVersion-Linux-x86_64.tar.gz
}
