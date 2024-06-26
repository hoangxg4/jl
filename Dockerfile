FROM ubuntu:latest

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo

# Cài đặt Jupyter
RUN pip3 install jupyter

# Tạo người dùng non-root
RUN useradd -m jupyteruser
RUN echo "jupyteruser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cài đặt thư mục làm việc
WORKDIR /home/jupyteruser

# Chuyển quyền sở hữu thư mục cho người dùng non-root
RUN chown -R jupyteruser:jupyteruser /home/jupyteruser

# Chuyển sang người dùng non-root
USER jupyteruser

# Expose cổng mặc định của Jupyter
EXPOSE 8888

# Khởi chạy Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
