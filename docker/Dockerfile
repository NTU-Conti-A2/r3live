FROM ros:noetic-perception
ARG DEBIAN_FRONTEND=noninteractive

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip python3-catkin-tools python3-rosdep && \
    apt autoremove && apt clean

# Create user account
RUN adduser --disabled-password --gecos '' --shell /bin/zsh user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user

# Switch to user
USER user

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
	-p z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

# Install packages required by r3live
RUN sudo apt update && sudo apt install -y \
    vim git curl wget build-essential ros-$ROS_DISTRO-rviz \
    ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-tf ros-$ROS_DISTRO-message-filters ros-$ROS_DISTRO-image-transport ros-$ROS_DISTRO-image-transport* \
    libcgal-dev pcl-tools && \
    sudo apt autoremove && sudo apt clean

# Install pip packages
# COPY requirements.txt /tmp/requirements.txt
# RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt

SHELL ["/bin/zsh", "-c"]

# Install livox_ros_driver
RUN . /opt/ros/$ROS_DISTRO/setup.zsh && \
    mkdir -p /home/user/catkin_ws/src && cd /home/user/catkin_ws/src && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git

COPY . /home/user/catkin_ws/src/r3live/
RUN . /opt/ros/$ROS_DISTRO/setup.zsh && \
    cd /home/user/catkin_ws && catkin init && rosdep update && rosdep install --from-paths src --ignore-src -r -y && \
    catkin build --start-with livox_ros_driver

COPY docker/ros_entrypoint.sh /
RUN sudo chmod +x /ros_entrypoint.sh && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.zsh" >> ~/.zshrc && sudo echo "source /home/user/catkin_ws/devel/setup.zsh" >> ~/.zshrc && \
    sudo rm -rf /home/user/catkin_ws/src/r3live

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/zsh"]