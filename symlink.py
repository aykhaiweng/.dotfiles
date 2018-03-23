import os
import datetime


HOME_DIR = os.environ.get('HOME')
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
BACKUP_DIR = os.path.join(HOME_DIR, 'backup/')


DIRECTORIES_TO_MAKE = (
    '.config',
    '.config/nvim',
    '.config/alacritty',
    '.config/kitty',
    '.vim/workspace-undodir/',
    '.vim/after',
    '.vim/after/plugins/',
)


# Tuples of source and targets
FILES_TO_LINK = (
    # profiles
    ('profiles/zshrc', '.zshrc'),
    ('profiles/aliases', '.aliases'),
    ('vim/vimrc', '.vimrc'),
    ('vim/after/highlights.vim', '.vim/after/plugins/highlights.vim'),
    ('ultisnips/', '.vim/ultisnips'),

    # tmux
    ('tmux/tmux.conf', '.tmux.conf'),
    ('tmux/tmux-osx.conf', '.tmux-osx.conf'),
    ('tmux/tmux-linux.conf', '.tmux-linux.conf'),

    # flake8
    ('config/flake8', '.config/flake8'),
    # nvim
    ('config/nvim', '.config/nvim/init.vim'),
    # alacritty
    ('config/alacritty_macos.yml', '.config/alacritty/alacritty.yml'),
    # kitty
    ('config/kitty.conf', '.config/kitty/kitty.conf'),
    ('config/kitty.conf', 'Library/Preferences/kitty/kitty.conf'),

    # tmux-gitbar
    ('config/.tmux-gitbar.conf', '.tmux-gitbar.conf'),

    # oh-my-zsh
    (
        'oh-my-zsh/themes/powerlevel9k/',
        '.oh-my-zsh/themes/powerlevel9k'
    ),
    (
        'oh-my-zsh/themes/bira-custom.zsh-theme',
        '.oh-my-zsh/themes/bira-custom.zsh-theme',
    )
)


def main():
    now = datetime.datetime.now()

    # Make directories
    for DIRNAME in DIRECTORIES_TO_MAKE:
        target_directory = os.path.join(HOME_DIR, DIRNAME)
        if os.path.exists(target_directory):
            print("Path for directory found, skipping make: {}".format(
                target_directory)
            )
            pass  # pass if directory already exists
        else:
            print("Creating directory: {}".format(target_directory))
            os.makedirs(target_directory)
    # Symlink files
    for SOURCE, TARGET in FILES_TO_LINK:
        print("Attempting to create symlink for " + TARGET)

        # Declare source and target file paths
        source_file = os.path.join(CURRENT_DIR, SOURCE)
        target_file = os.path.join(HOME_DIR, TARGET)

        if os.path.exists(source_file) is False:
            print("ERROR! Source file specified does not exist: {}".format(
                source_file
            ))

        # Make the backup dir
        if os.path.isdir(BACKUP_DIR) is False:
            os.makedirs(BACKUP_DIR)

        # Create the backed up items one by one
        if os.path.exists(target_file):
            if os.path.islink(target_file) is False:
                target_file_bak_name = "{name}.bak.{dt}".format(
                    name=TARGET,
                    dt=now.strftime("%Y%m%d_%H%M%S")
                )
                print(target_file_bak_name)
                target_file_bak_path = os.path.join(
                    BACKUP_DIR,
                    target_file_bak_name
                )
                os.rename(target_file, target_file_bak_path)
                print(
                    "File found, backup created: "
                    "{source} --> {target}".format(
                        source=target_file,
                        target=target_file_bak_path
                    )
                )
            else:
                os.remove(target_file)
                print(
                    "File found, symlink deleted: "
                    "{target}".format(target=target_file)
                )

        # Create symlink
        print("Creating symlink... {source} --> {target}".format(
            source=source_file,
            target=target_file
        ))
        try:
            os.symlink(
                source_file,
                target_file,
                target_is_directory=os.path.isdir(target_file)
            )
        except FileExistsError:
            os.remove(target_file)
            os.symlink(source_file, target_file)
        except FileNotFoundError:
            print("Could not create the symlink for {target}".format(
                target=target_file
            ))


if __name__ == '__main__':
    main()
