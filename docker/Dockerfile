FROM ros:noetic-perception
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
    # basic tools
    vim git curl wget build-essential python3-rosdep python3-catkin-tools ros-$ROS_DISTRO-rviz \
    # Dependencies stated by original authors
    ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-tf ros-$ROS_DISTRO-message-filters ros-$ROS_DISTRO-image-transport ros-$ROS_DISTRO-image-transport* \
    # Install CGAL and pcl_viewer (optional)
    libcgal-dev pcl-tools && \
    apt clean

# Install livox_ros_driver
RUN mkdir -p /catkin_ws/src && \
    cd /catkin_ws/src && git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
    . /opt/ros/$ROS_DISTRO/setup.sh && \
    cd /catkin_ws && catkin init && rosdep update && rosdep install --from-paths src --ignore-src -r -y && \
    catkin build livox_ros_driver

# Install r3live
RUN cd /catkin_ws/src && git clone https://github.com/hku-mars/r3live.git && \
    . /opt/ros/$ROS_DISTRO/setup.sh && . /catkin_ws/devel/setup.sh && \
    cd /catkin_ws && rosdep install --from-paths src --ignore-src -r -y && \
    catkin build r3live

# Cleanup
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash\nsource /catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    rm -rf /catkin_ws/src/r3live

CMD [ "/bin/bash" ]
