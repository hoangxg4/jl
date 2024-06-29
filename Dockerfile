# Sử dụng image Python làm nền tảng, phiên bản slim để tiết kiệm dung lượng
FROM python:3.9-slim-buster

# Cài đặt các thư viện và công cụ cần thiết (wget, curl, build-essential)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt JupyterLab và các extensions phổ biến
RUN pip install --upgrade pip \
    && pip install jupyterlab \
    ipywidgets \
    pandas \
    matplotlib \
    numpy \
    seaborn 

# Tạo thư mục làm việc cho JupyterLab
WORKDIR /workspace

# Tạo tệp cấu hình JupyterLab
RUN jupyter lab --generate-config

# Đặt token (thay '11042006' bằng token của bạn)
RUN echo "c.ServerApp.token = '11042006'" >> /root/.jupyter/jupyter_notebook_config.py

# Cấu hình JupyterLab để mở trong thư mục hiện tại khi khởi động
RUN echo "c.ServerApp.notebook_dir = '/workspace'" >> /root/.jupyter/jupyter_notebook_config.py

# Mở cổng 8888 để truy cập JupyterLab từ trình duyệt
EXPOSE 8888

# Khởi động JupyterLab khi container chạy
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
