#!/bin/sh

DATA_DIR=/data/dokuwiki
TARGET_DIR=/usr/local/share/dokuwiki

# Initialization
INIT_TOKEN=/data/.initialized
if [ ! -f "$INIT_TOKEN" ]; then
    echo "Initializing..."

    mkdir -p $DATA_DIR
    mv /init/data $DATA_DIR
    mv /init/conf $DATA_DIR
    rm -r /init

    touch $INIT_TOKEN

    echo "... DONE."
fi

# Finalize
if [ ! -L "$DATA_DIR/data" ]; then
    ln -s $DATA_DIR/data $TARGET_DIR/data
fi

if [ ! -L "$DATA_DIR/conf" ]; then
    ln -s $DATA_DIR/conf $TARGET_DIR/conf
fi
