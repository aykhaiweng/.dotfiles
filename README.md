# Intro
All the files in here are run according to sorting order upon running the `bin/dotfiles` script.

## First Time Install
Run the script below:
`wget --no-cache -O - https://raw.githubusercontent.com/aykhaiweng/.dotfiles/master/bin/dotfiles | sh`
## What the `/bin/dotfiles` script does
So, the `/bin/dotfiles` script is the primary entrypoint for creating the environment that I often use for work.

### ~/.dotfiles/bin/
All the files in here are executables that can be accessed from the CLI

### ~/.dotfiles/source/
These things are ran every time a shell spins up

### ~/.dotfiles/link/
These files are symbolically linked to ~/ and the files it overwrites are backed up

### ~/.dotfiles/copy/
These files are copied to ~/

# Considerations
[TO BE ADDED]

# Special Thanks!
[Ben Alman @cowboy](https://github.com/cowboy/dotfiles) - Most of this guide is composed of ideas taken from his .dotfiles script.
