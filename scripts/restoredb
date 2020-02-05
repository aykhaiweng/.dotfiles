#! /usr/bin/env python
import argparse
import getpass
import os
import subprocess

HELP_TEXT = (
    "Helper script to restore database"
)


def check_args(args):
    """
    Check the arguments
    """
    # Check that the file exists
    assert os.path.isfile(args['file']) == True, "File does not exist!"


def main(*args, **kwargs):
    """
    Main entrypoint
    """
    # Delete the DB
    stdout, stderr = subprocess.Popen(
        ['dropdb', kwargs['database']],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    ).communicate()
    if stdout:
        print(stdout.decode('UTF-8'))
    else:
        print("Database dropped!")

    # Create the DB
    stdout, stderr = subprocess.Popen(
        ['createdb', kwargs['database']],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    ).communicate()
    if stdout:
        print(stdout.decode('UTF-8'))
    else:
        print("Database created!")

    # Invoke the PSQL command
    cmdargs = [
        "psql", "-U", kwargs['user']
    ] + extra + [
        kwargs['database'], "<", kwargs['file']
    ]
    print(cmdargs)
    stdout, stderr = subprocess.Popen(
        cmdargs,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    ).communicate()
    if stdout:
        print(stdout.decode('UTF-8'))
    else:
        print("Database created!")


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=HELP_TEXT)
    ap.add_argument(
        'database',
        metavar='database',
        type=str,
        help='Database to be restored',
    )
    ap.add_argument(
        'file',
        metavar='file',
        type=str,
        help='Path to file to be used in restoring the database',
    )
    ap.add_argument(
        '--user',
        '-u',
        metavar='username',
        type=str,
        help='Username for the PSQL invocation',
        default=getpass.getuser(),
    )

    # Grab all the arguments
    args, extra = ap.parse_known_args()
    args = vars(args)
    args.update(extra=extra)

    check_args(args)
    main(**args)
