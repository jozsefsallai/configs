#!/bin/bash

if [ -f "extensions.txt" ]; then
  touch extensions.txt
fi

OPERATION="$1"
ARGUMENT="$2"

add_extension () {
  local name="$1"

  if [ -z "$name" ]; then
    echo "error: Please provide the name of the extension you want to add."
    exit 1;
  fi

  if grep -Fxq "$name" extensions.txt; then
    echo "warning: This extension is already added. No changes have been made."
    exit 2;
  fi

  echo "$name" >> extensions.txt
}

delete_extension () {
  local name="$1"

  if [ -z "$name" ]; then
    echo "error: Please provide the name of the extension you want to delete."
    exit 1;
  fi

  if grep -Fxq "$name" extensions.txt; then
    sed -i "/$name/d" extensions.txt
    echo "Done."
    exit 0;
  fi

  echo "Extension not found."
  exit 2;
}

if [ "$OPERATION" == "add" ]; then
  echo "Adding extension..."
  add_extension $ARGUMENT
  echo "Extension added."
fi

if [ "$OPERATION" == "delete" ]; then
  echo "Deleting extension..."
  delete_extension $ARGUMENT
fi

echo "Sorting extensions..."

sort -t= extensions.txt -o extensions.txt

echo "Extensions sorted."

echo "Done."
exit
