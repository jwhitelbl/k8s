#!/bin/sh
echo "============" >> /config/unpack.log
date >> /config/unpack.log
echo "$TR_TORRENT_DIR/$TR_TORRENT_NAME" >> /config/unpack.log
cd $TR_TORRENT_DIR/$TR_TORRENT_NAME
FIRST=`ls *.rar`
SECOND=`ls *.r00`
THIRD=`ls *.r01`

if [ "$FIRST" != "" ]; then
	echo "$FIRST" >> /config/unpack.log
        /usr/local/bin/unrar x "$FIRST" | tail -5 >> /config/unpack.log
	exit 0
fi
if [ "$SECOND" != "" ]; then
	echo "$SECOND" >> /config/unpack.log
        /usr/local/bin/unrar x "$SECOND" | tail -5 >> /config/unpack.log
	exit 0
fi
if [ "$THIRD" != "" ]; then
	echo "$THIRD" >> /config/unpack.log
	/usr/local/bin/unrar x "$THIRD" | tail -5 >> /config/unpack.log
else
	echo "no unpack needed" >> /config/unpack.log
fi
