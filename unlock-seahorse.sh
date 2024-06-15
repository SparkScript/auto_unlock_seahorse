#!/bin/bash

NITRO=<YOUR_NITROPY_INSTALL>
PYTHON=/usr/bin/python3
DOTOOL=/usr/local/bin/dotool
TRIGGER_SCRIPT=<YOUR_PATH_TO>/trigger-seahorse.py
PASSWORDNAME=<YOUR_PASSWORD_NAME>

$NITRO nk3 status 2>&1 > /dev/null
if [ "$?" -eq "0" ]; then
        password=$($NITRO nk3 secrets get-password $PASSWORDNAME --password)
        if [ "$?" -eq 0 ]; then
                $PYTHON $TRIGGER_SCRIPT $password $DOTOOL
        else
                echo "No password found!"
        fi
fi
