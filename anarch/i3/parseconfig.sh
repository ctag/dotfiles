#!/bin/bash

#
# This script will take the full system i3 config and merge it with the configs specfic to each gpu
#

more config > gpu0config
more config > gpu1config
more gpu0part >> gpu0config
more gpu1part >> gpu1config
