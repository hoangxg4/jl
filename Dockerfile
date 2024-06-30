# Sử dụng image Ubuntu làm cơ sở
FROM ubuntu:latest

# Cập nhật hệ thống và cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y \
        nginx \
        curl \
        vim \
        net-tools \
        sudo \
        openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Tạo người dùng mới và cấp quyền sudo
RUN useradd -rm -d /home/vpsuser -s /bin/bash -g root -G sudo -u 1000 vpsuser
RUN echo 'vpsuser:password' | chpasswd

# Cấu hình SSH
RUN mkdir /home/vpsuser/.ssh
RUN chmod 700 /home/vpsuser/.ssh
RUN touch /home/vpsuser/.ssh/authorized_keys
RUN chmod 600 /home/vpsuser/.ssh/authorized_keys

# Sao chép cấu hình SSH (tùy chọn)
COPY sshd_config /etc/ssh/sshd_config

# Khởi động SSH
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
