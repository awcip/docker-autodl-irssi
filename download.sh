#!/bin/bash
# Download torrent file and check if it already exists

filterName=$1
Category=$2
TrackerShort=$3
TorrentName=$4
TorrentUrl=$5

echo "$filterName $Category $TrackerShort $TorrentName $TorrentUrl" \
    >> "/home/user/download.log"

file="/autotorrent/$Category/$TorrentName-$TrackerShort.torrent"
wget $TorrentUrl \
    --output-document="$file" \
    --append-output="/home/user/download.log" \
    --tries 3 \
    --no-verbose

filehead=$(head -c 15 "$file")
if [[ "$filehead" == *"announce"* ]]; then
    echo "Good filehead: $filehead" >> "/home/user/download.log"
else
    echo "Bad filehead: $filehead" >> "/home/user/download.log"
    echo "Removing $file" >> "/home/user/download.log"
    rm -f "$file"
    exit
fi

flock -s /autotorrent/autotorrent.lock \
      autotorrent-env/bin/autotorrent \
      --config /autotorrent/autotorrent.conf --client deluge \
      -d -a "$file" \
      >> /home/user/download.log
