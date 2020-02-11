#!/usr/bin/env bash

shell_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# Ask for administrator password
sudo -v

# update existing `sudo` timestamp
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/sbin
chmod u+w /usr/local/bin /usr/local/lib /usr/local/sbin

