#!/usr/bin/env bash
mpstat 1 1 | grep "Average" | awk '{usage=($3+$4+$5+$6+$7+$8+$9+$10+$11)} END {printf("%d\n",usage + 0.5)}'
