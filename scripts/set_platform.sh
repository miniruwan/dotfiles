platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  if ( grep -q microsoft /proc/version ); then
    platform='wsl'
  else
    platform='linux'
  fi
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
elif [[ `uname` == 'CYGWIN'* ]]; then
   platform='cygwin'
fi
