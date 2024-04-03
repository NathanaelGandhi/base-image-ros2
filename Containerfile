FROM ros:humble

################################################################################
# Adds non-root user
ARG USERNAME=builder
ARG USER_UID=2000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
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
