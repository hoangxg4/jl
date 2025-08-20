FROM python:3.12-alpine

# Cài đặt các gói cần thiết để build và chạy JupyterLab
RUN apk add --no-cache \
    bash \
    sudo \
    build-base \
    libffi-dev \
    openssl-dev \
    && pip install --no-cache-dir --upgrade pip \
    && pip config set global.break-system-packages true \
    && pip install --no-cache-dir jupyterlab \
    && apk del build-base libffi-dev openssl-dev

# Thư mục làm việc
WORKDIR /root

# Mở cổng 8888
EXPOSE 8888

# Chạy JupyterLab (token cố định)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=11042006"]
