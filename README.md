# Joe's Environment Configs

This repository holds my config files and other stuff to make it easier to migrate to a new development or production workstation.

## Prerequisites
  * git
  * Visual Studio Code
  * Git for Windows with git-bash (Windows-only)

## Installation

Clone the repository:

```
git clone git@github.com:jozsefsallai/configs.git
```

Install the vscode extensions:

```
sh vscode/install.sh
```

## Visual Studio Code Extensions

A shell script is included to help you add, delete, and sort the list of Visual Studio Code extensions.

**Usage:**

```sh
# Sorting:
./vscext

# Adding:
./vscext add extension-author.extension-id

# Deleting:
./vscext delete extension-author.extension-id
```

## Production Setup

For initial server setups, run the following command:

```sh
sh setup.server.sh
```
