# Sử dụng ảnh cơ sở Python
FROM python:3.11-slim-buster

# Cài đặt các gói hệ thống cần thiết
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    vim \
    build-essential

# Tạo người dùng mới có quyền sudo
RUN useradd -m -s /bin/bash jupiter && \
    echo "jupiter:jupiter" | chpasswd && \
    adduser jupiter sudo

# Chuyển sang người dùng mới
USER jupiter

# Cài đặt JupyterLab và các thư viện Python cần thiết
RUN pip install --upgrade pip \
    jupyterlab

# Cấu hình JupyterLab
RUN mkdir /home/jupiter/.jupyter && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/jupiter/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_root = True" >> /home/jupiter/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /home/jupiter/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> /home/jupiter/.jupyter/jupyter_notebook_config.py

# Mở cổng 8888 cho JupyterLab
EXPOSE 8888

# Khởi động JupyterLab khi container chạy
CMD ["jupyter", "lab", "--allow-root"]
