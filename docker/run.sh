#!/bin/sh

R3LIVE_FOLDER=/home/dawei/repo/r3live
ROSBAG_FOLDER=/mnt/c/Users/Public/rosbags/r3live_rosbags
OUTPUT_FOLDER=/mnt/c/Users/Public/wsl_data

# Need to expose host linux x11 server for GUI to be displayed on host (unsafe if on shared system. comment out and use xauth is needed)
xhost +local:root

# add --network=host if needed
docker run -it --rm --name r3live \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    -v $ROSBAG_FOLDER:/rosbags \
    -v $OUTPUT_FOLDER:/data \
    -v $R3LIVE_FOLDER:/catkin_ws/src/r3live \
    --gpus all r3live:noetic bash