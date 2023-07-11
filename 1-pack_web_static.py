#!/usr/bin/python3
"""generates a .tgz archive from the contents of the web_static folder

"""
from fabric.api import local
from datetime import datetime


def do_pack():
    """Function to compress directory

    Return: path to archive on success; None on fail
    """
    # Get current time
    now = datetime.now()
    now = now.strftime('%Y%m%d%H%M%S')
    archive_path = 'versions/web_static_<year><month><day><hour><minute><second>.tgz

    # Create archive
    local('mkdir -p versions/')
    result = local('tar -cvzf {} web_static/'.format(archive_path))

    # Check if archiving was successful
    if result.succeeded:
        return archive_path
    return None
