#!/bin/sh
echo "============" >> /config/unpack.log
date >> /config/unpack.log
echo "$TR_TORRENT_DIR/$TR_TORRENT_NAME" >> /config/unpack.log
cd $TR_TORRENT_DIR/$TR_TORRENT_NAME
FILE=`find . | grep -E 'rar|r00' | tail -1`

if [ "$FILE" != "" ]; then
	echo "$FILE" >> /config/unpack.log
        /usr/local/bin/unrar x "$FILE" | tail -5 >> /config/unpack.log
	exit 0
else
	echo "no unpack needed" >> /config/unpack.log
fi
