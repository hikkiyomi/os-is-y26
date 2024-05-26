#!/bin/bash

./mem.sh &
./mem2.sh &

./watcher.sh watcher.log mem.sh &
./watcher.sh watcher2.log mem2.sh &

