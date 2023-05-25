#!/bin/sh
R3LIVE_FOLDER=/home/dawei/repo/r3live
ROSBAG_FOLDER=/mnt/c/Users/Public/rosbags
OUTPUT_FOLDER=/mnt/c/Users/Public/wsl_data

# add --network=host if needed
docker run -it --rm --name r3live \
    --network=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /mnt/wslg:/mnt/wslg \
    -v /usr/lib/wsl:/usr/lib/wsl \
    --device=/dev/dxg \
    -e DISPLAY=$DISPLAY \
    -e LD_LIBRARY_PATH=/usr/lib/wsl/lib \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    -e PULSE_SERVER=$PULSE_SERVER \
    -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    -v $ROSBAG_FOLDER:/home/user/rosbags \
    -v $OUTPUT_FOLDER:/home/user/r3live_output \
    -v $R3LIVE_FOLDER:/home/user/catkin_ws/src/r3live \
    -u $(id -u):$(id -g) \
    --gpus all r3live:noetic zsh