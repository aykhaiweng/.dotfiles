#!/usr/bin/env python3
import argparse
import getpass
import os
import subprocess
import json


RSYNC_BIN = "rsync"
RSYNC_ARGS = [
    '-v',       # Increase verbosity
    '-zar',
    '-q',       # Surpress non-error messages
    '-p',       # Shows progress during transfer
    '-o',       # Maintain ownership
]
DEFAULT_JSON_CONFIG_NAME = "rsync.json"
SCRIPT_HELP_TEXT = "Wrapper script to make rsync more extendable"
CWD = os.getcwd()


def search_parents_for_file(filename, cwd=None):
    """
    Recursively search upwards for rsync config file

    Khai, 04.02.2020
    """
    # Starting variables
    target_file = None
    cur_dir = cwd

    # Check if it is a full path
    if filename[0] == '/':
        target_file = filename
    else:
        while True:
            file_list = os.listdir(cur_dir)
            parent_dir = os.path.dirname(cur_dir)
            if filename in file_list:
                target_file = os.path.join(cur_dir, filename)
                break
            else:
                if cur_dir == parent_dir:  # if dir is root dir
                    break
                else:
                    cur_dir = parent_dir

    assert bool(target_file) is True, "Unexpected Error, target_file not specified."
    assert os.path.isfile(target_file) is True, f"Could not find config file (path: {target_file})"

    return target_file


def parse_json_config(file_path):
    """
    Read the JSON config and change it into a list of dictionaries

    Khai, 04.02.2020
    """
    with open(file_path) as config_file:
        payload = json.load(config_file)

    parsed_arguments = []
    global_options = payload['options']
    global_excludes = payload['excludes']

    for local_path, remote_payloads in payload['remotes'].items():
        # Fallback
        if local_path == ".":
            # Use the directory of the file if the local path is .
            local_path = os.path.join(os.path.dirname(file_path), '.')

        elif os.path.isdir(local_path) is False:
            print(f"Path to \'{local_path}\' not found. Skipping...")
            continue

        for remote_payload in remote_payloads:
            if remote_payload['enabled'] is False:
                continue

            excludes = remote_payload['excludes'] + global_excludes
            options = remote_payload['options'] + global_options
            parsed_arguments.append({
                "local_dir": local_path,
                "excludes": excludes,
                "options": options,
                "ssh": remote_payload.get('ssh', "ssh"),
                "remote_host": remote_payload['remote_host'],
                "remote_path": remote_payload['remote_path'],
                "remote_port": remote_payload.get('remote_port', None),
                "remote_user": remote_payload['remote_user'],
            })

    return parsed_arguments


def build_command_list_for_rsync(rsync_bin, payload, direction='up', extras=[]):
    """
    Build a command list for running rsync
    """
    # Base of the command
    command_list = [rsync_bin] + RSYNC_ARGS

    # Add in SSH command
    command_list += [f'-e \'{payload["ssh"]}\'']

    # Build port and local paths
    if payload['remote_port']:
        command_list += ['-p', f'{payload["remote_port"]}']

    # Add the options in
    command_list += payload['options']

    # Check for extras
    if extras:
        # Added extras
        command_list += extras

    # Add the local dir in
    local_command = [payload['local_dir']]

    # Add the remote dir in
    remote_command = [
        f'{payload["remote_user"]}@{payload["remote_host"]}:\'{payload["remote_path"]}\''
    ]

    if direction == 'up':
        command_list += local_command
        command_list += remote_command
    elif direction == 'down':
        command_list += remote_command
        command_list += local_command

    # Build the excludes
    for exclude in payload['excludes']:
        command_list += [f'--exclude={exclude}']

    return command_list


def build_command_lists_for_rsync(rsync_bin, parsed_arguments, direction='up', extras=[]):
    command_lists = []
    for arg_set in parsed_arguments:
        command_lists.append(
            build_command_list_for_rsync(
                rsync_bin,
                arg_set,
                direction=direction,
                extras=extras
            )
        )

    return command_lists


def execute_command_list(command_list):
    """
    Execute command list
    """
    print(f"Executing: {command_list}")
    stdout = subprocess.run(command_list)
    if stdout.returncode != 0:
        print(stdout)


def main(*args, **kwargs):
    """
    Main Program

    Khai, 04.02.2020
    """
    config_file_path = search_parents_for_file(kwargs['file'], cwd=CWD)

    parsed_arguments = parse_json_config(config_file_path)

    command_lists = build_command_lists_for_rsync(
        kwargs['bin'], parsed_arguments, direction=kwargs.get('direction', 'up'), extras=kwargs['extra']
    )

    for c in command_lists:
        execute_command_list(c)


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=SCRIPT_HELP_TEXT)
    ap.add_argument(
        '--file',
        '-f',
        type=str,
        help='Config file for wrapper',
        default=DEFAULT_JSON_CONFIG_NAME,
    )
    ap.add_argument(
        '--direction',
        '-d',
        type=str,
        help='Direction of the Transfer',
        default='up',
    )
    ap.add_argument(
        '--user',
        '-u',
        type=str,
        help='Username for the PSQL invocation',
        default=getpass.getuser(),
    )
    ap.add_argument(
        '--bin',
        type=str,
        help='Path to rsync binary',
        default=RSYNC_BIN,
    )

    # Grab all the arguments
    args, extra = ap.parse_known_args()

    args = vars(args)
    args.update(extra=extra)

    main(**args)
