#!/bin/zsh
set -e

# setup ros environment
source /opt/ros/$ROS_DISTRO/setup.zsh
source /home/user/catkin_ws/devel/setup.zsh

exec "$@"