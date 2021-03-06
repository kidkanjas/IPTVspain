#!/bin/bash

EPG_url="https://raw.githubusercontent.com/vk496/IPTVspain/master/guide.xml"

echo "#EXTM3U" > spain.m3u8

cat README.md | sed -n '/canales hay/,/Agradecimientos/{/canales hay/b;/Agradecimientos/b;p}' | tail -n +3 | \
while read line; do
	img=$(echo $line | cut -d\| -f2 | cut -d\" -f2)
	name=$(echo $line | cut -d\| -f3)
	epgID=$(echo $line | cut -d\| -f4)
	m3u8=$(echo $line | cut -d\| -f5 | cut -d\( -f2 | cut -d\) -f1)
	categ=$(echo $line | cut -d\| -f6)

	if [[ $m3u8 == \#* ]]; then
		script=$(echo $m3u8 | cut -d\# -f2-)
		m3u8_new=$(./custom/$script)

		if [[ $m3u8_new == h* ]]; then
			m3u8=$m3u8_new
		fi
	fi

	echo "#EXTINF:-1 group-title=\"$categ\" tvg-id=\"$epgID\" tvg-logo=\"$img\" url-epg=\"$EPG_url\",$name" >> spain.m3u8
	echo "$m3u8" >> spain.m3u8
done
