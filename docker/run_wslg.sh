#!/bin/sh
# add --network=host if needed
docker run -it --name r3live \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /mnt/wslg:/mnt/wslg \
    -v /usr/lib/wsl:/usr/lib/wsl \
    --device=/dev/dxg \
    -e DISPLAY=$DISPLAY \
    -e LD_LIBRARY_PATH=/usr/lib/wsl/lib \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    -e PULSE_SERVER=$PULSE_SERVER \
    -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    -v /mnt/c/Users/Public/rosbags/r3live_rosbags:/data \
    --gpus all r3live:noetic bash