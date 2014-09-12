#!/usr/bin/env python
import os
import sys
import SocketServer
from wsgiref import handlers

SocketServer.BaseServer.handle_error = lambda *args, **kwargs: None
handlers.BaseHandler.log_exception = lambda *args, **kwargs: None

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "DjangoApp.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
