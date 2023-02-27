# Not using ros:melodic-perception as the default opencv version shipped is v3.2 not compatible with r3live
FROM ros:melodic-ros-base
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
    # basic tools
    vim git curl wget build-essential python-rosdep python-catkin-tools libgtk2.0-dev \
    # Dependencies stated by original authors
    ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-tf ros-$ROS_DISTRO-message-filters ros-$ROS_DISTRO-image-transport ros-$ROS_DISTRO-image-transport* ros-$ROS_DISTRO-rviz \
    # dependencies not stated
    ros-$ROS_DISTRO-eigen-conversions \
    # Install CGAL and pcl_viewer (optional)
    libcgal-dev pcl-tools

# Install opencv 3.4.16 for kinetic/melodic 
RUN cd /root && git clone https://github.com/opencv/opencv.git && \
    cd /root/opencv && git checkout tags/3.4.16 && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_TBB=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D WITH_V4L=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D BUILD_EXAMPLES=ON \
    -D WITH_QT=ON \
    -D WITH_GTK=ON \
    -D WITH_OPENGL=ON .. && \
    make -j $(nproc) && make install

# Install livox_ros_driver and r3live
RUN mkdir -p /catkin_ws/src && cd /catkin_ws/src && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
    git clone https://github.com/hku-mars/r3live.git && \
    cd /catkin_ws && catkin init && rosdep update && rosdep install --from-paths src --ignore-src -r -y

# For melodic lz4 error
RUN mv /usr/include/flann/ext/lz4.h /usr/include/flann/ext/lz4.h.bak && \
    mv /usr/include/flann/ext/lz4hc.h /usr/include/flann/ext/lz4.h.bak && \
    ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h && \
    ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h

# COPY r3live/CMakeLists.txt /catkin_ws/src/r3live
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    # export CMAKE_PREFIX_PATH=/usr/local:$CMAKE_PREFIX_PATH && \
    cd /catkin_ws && catkin build --start-with livox_ros_driver

# Cleanup
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash\nsource /catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    rm -rf /catkin_ws/src/r3live && apt clean

CMD [ "/bin/bash" ]
