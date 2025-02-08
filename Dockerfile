# Sử dụng Ubuntu làm base image
FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    sudo \
    python3 \
    python3-pip \
    && apt-get clean

# Tạo môi trường ảo và cài đặt JupyterLab
RUN python3 -m pip config set global.break-system-packages true
RUN pip3 install jupyterlab

# Tạo thư mục làm việc
WORKDIR /root

# Mở cổng 8888 cho JupyterLab
EXPOSE 8888

# Khởi động JupyterLab với quyền root và token
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token='11042006'"]
