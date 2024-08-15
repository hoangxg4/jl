# Sử dụng image chính thức của Python làm image gốc
FROM python:3.9

# Cập nhật danh sách package và cài đặt pip
RUN apt-get update && apt-get install -y \
    python3-pip

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Tạo thư mục làm việc
WORKDIR /root

# Mở cổng 8888 để truy cập JupyterLab
EXPOSE 8888

# Khởi động JupyterLab khi container chạy và đặt token đăng nhập
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token='11042006'"]
