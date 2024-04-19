ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}
LABEL ROS_DISTRO=${ROS_DISTRO}
LABEL NAME="base-image-ros2"

################################################################################
# Adds non-root user
ARG USERNAME=builder
ARG USER_UID=2000
ARG USER_GID=$USER_UID

# Create the user
RUN if [ "$(id -un)" != "$USERNAME" ] ; then \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --shell /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME; \
    fi
USER $USERNAME

################################################################################
# Install apt packages
## python3-pip required by ros2
RUN sudo apt-get update && sudo apt-get upgrade -y && \
    sudo apt-get install -y \
    python3-pip

################################################################################
# Install pip packages

################################################################################
# Create directories for file storage like on the real OBC
RUN sudo mkdir -p /data/stored /data/live

################################################################################
ENTRYPOINT ["/bin/bash"]
