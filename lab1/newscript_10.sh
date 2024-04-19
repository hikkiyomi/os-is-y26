#!/bin/bash

man bash | grep -Eiho '[[:alpha:]]{4,}' | sort -f | uniq -ic | sort -rn -k1 | head -n 3
