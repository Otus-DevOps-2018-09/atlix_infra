#!/bin/bash
INVFILE=inventory.json

if [ ! -f ./$INVFILE ]; then
    echo "File not found!"
else
    cat $INVFILE
fi
