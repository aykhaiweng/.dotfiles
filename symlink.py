import os
import shutil
import datetime


HOME_DIR = os.environ.get('HOME')
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
BACKUP_DIR = os.path.join(HOME_DIR, 'backup/')


# Tuples of source and targets
FILES_TO_LINK = (
    # profiles
    ('profiles/zshrc', '.zshrc'),
    ('profiles/aliases', '.aliases'),
    ('profiles/tmux.conf', '.tmux.conf'),
    ('profiles/vimrc', '.vimrc'),
    # oh-my-zsh
    (
        '.oh-my-zsh/themes/powerlevel9k/',
        '.oh-my-zsh/themes/powerlevel9k'
    ),
    (
        '.oh-my-zsh/themes/bira-custom.zsh-theme',
        '.oh-my-zsh/themes/bira-custom.zsh-theme',
    )

)

def main():
    now = datetime.datetime.now()

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
                print("File found, backup created: "
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


if __name__ == '__main__':
    main()
