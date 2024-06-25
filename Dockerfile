FROM python:3.10-slim-buster

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    sudo \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Tạo người dùng jupyter và đặt mật khẩu (thay 'your_password' bằng mật khẩu mạnh)
RUN useradd -m -s /bin/bash jupyter \
    && echo "jupyter:11042006" | chpasswd

# Thiết lập thư mục làm việc và quyền sở hữu
WORKDIR /home/jupyter

# Cài đặt JupyterLab
RUN pip install --upgrade pip \
    && pip install jupyterlab

# Cấu hình JupyterLab
COPY jupyter_lab_config.py /home/jupyter/.jupyter/jupyter_lab_config.py

# Sao chép script khởi động
COPY start.sh /home/jupyter/start.sh
RUN chmod +x /home/jupyter/start.sh

# Cấu hình Jupyter Notebook để cho phép truy cập từ xa
ENV JUPYTER_ENABLE_LAB=yes

# Cổng Jupyter Notebook
EXPOSE 8888

# Chạy JupyterLab khi container khởi động, bắt đầu với người dùng 'jupyter'
USER jupyter
CMD ["/home/jupyter/start.sh"]
