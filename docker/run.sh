#!/bin/sh

R3LIVE_FOLDER=/home/dawei/repo/r3live
ROSBAG_FOLDER=/mnt/c/Users/Public/rosbags/r3live_rosbags
OUTPUT_FOLDER=/mnt/c/Users/Public/wsl_data

# add --network=host if needed
docker run -it --rm --name r3live \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    -u $(id -u):$(id -g) \
    -v $ROSBAG_FOLDER:/home/user/rosbags \
    -v $OUTPUT_FOLDER:/home/user/r3live_output \
    -v $R3LIVE_FOLDER:/home/user/catkin_ws/src/r3live \
    --gpus all r3live:noetic zsh