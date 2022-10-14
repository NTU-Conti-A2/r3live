#!/bin/sh
# Need to expose host linux x11 server for GUI to be displayed on host (unsafe if on shared system. comment out and use xauth is needed)
xhost +local:root

# add --network=host if needed
docker run -itd --name r3live \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    --gpus all r3live:noetic bash