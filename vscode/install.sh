#!/bin/bash

in_array () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

if [ $# -eq 0 ]; then
  echo "Please provide an environment (linux, windows, mac)"
  exit 1
fi

ENV="unknown"

for env in "linux" "windows" "mac"; do
  if [ "$1" == "$env" ]; then
    ENV="$env"
  fi
done

if [ "$ENV" == "unknown" ]; then
  echo "Unknown environment $1"
  exit 1
fi

# Installing vscode extensions
echo "Installing Visual Studio Code extensions. This will take a while..."

INSTALLED_EXTENSIONS=$(code --list-extensions)
EXTENSIONS_LIST=$(cat vscode/extensions.txt)

readarray -t INSTALLED_EXTENSIONS_ARRAY <<< "$INSTALLED_EXTENSIONS"
readarray -t EXTENSIONS_LIST_ARRAY <<< "$EXTENSIONS_LIST"

for ext in "${EXTENSIONS_LIST_ARRAY[@]}"; do
  if in_array "$ext" "${INSTALLED_EXTENSIONS_ARRAY[@]}"; then
    echo "$ext is already installed. Skipping."
  else
    code --install-extension $ext
  fi
done

# cat vscode/extensions.txt | xargs -L1 code --install-extension

# Replacing vscode config
echo "Replacing Visual Studio Code user configfile..."

case $ENV in
  linux)
    configfile="~/.config/Code/User/settings.json"
    ;;
  windows)
    configfile="$APPDATA/Code/User/settings.json"
    ;;
  mac)
    configfile="~/Library/Application Support/Code/User/settings.json"
    ;;
esac

if [ -f "$configfile" ]; then
  rm "$configfile"
fi

cp vscode/settings.json "$configfile"

echo "Done."
exit
