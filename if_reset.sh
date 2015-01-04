#!/bin/bash

ip link set $1 down

sleep 240

ip link set $1 up
