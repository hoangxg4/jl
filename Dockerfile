FROM python:3.12-slim

# Cập nhật hệ thống và cài đặt sudo (nếu cần)
RUN apt-get update && apt-get install -y \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Cấu hình pip cho phép break-system-packages
RUN python3 -m pip config set global.break-system-packages true

# Cài đặt JupyterLab
RUN pip install --no-cache-dir jupyterlab

# Tạo thư mục làm việc
WORKDIR /root

# Mở cổng 8888 cho JupyterLab
EXPOSE 8888

# Khởi động JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=11042006"]
