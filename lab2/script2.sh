#!/bin/bash

ps ax | grep '/sbin/' | head -n -1 | awk '{ print $1 }' > output2
