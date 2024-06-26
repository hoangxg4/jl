# Use the official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3-pip sudo && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and add to sudo group
RUN useradd -m -s /bin/bash jupyter && \
    echo 'jupyter ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set the default user to root
USER root

# Install Jupyter
RUN pip3 install jupyter

# Copy Jupyter config file if needed
# COPY jupyter_notebook_config.py /home/jupyter/.jupyter/

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Set the working directory
WORKDIR /home/jupyter

# Start Jupyter Notebook as the default command
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

# Switch to non-root user
USER jupyter
