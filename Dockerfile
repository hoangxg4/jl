# Sử dụng hình ảnh cơ sở Ubuntu
FROM ubuntu:latest

# Thêm cấu hình để vô hiệu hóa cờ "no new privileges"
RUN echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf

# Cập nhật hệ thống và cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y sudo python3-pip && \
    pip3 install jupyterlab

# Thêm người dùng mới và gán quyền sudo
RUN useradd -ms /bin/bash newuser && \
    echo "newuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Chuyển sang người dùng mới
USER newuser

# Tạo một thư mục làm thư mục làm việc và thiết lập môi trường cho Jupyter
WORKDIR /workspace
ENV PATH="/home/newuser/.local/bin:${PATH}"

# Chạy Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
