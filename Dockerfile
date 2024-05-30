# Sử dụng base image của Python
FROM python:3.9-slim

# Thiết lập biến môi trường
ENV PYTHONUNBUFFERED=1

# Cài đặt các dependencies cần thiết
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --no-cache-dir jupyter

# Tạo thư mục làm việc và đặt nó làm thư mục hiện tại
WORKDIR /workspace

# Expose cổng 8888
EXPOSE 8888

# Lệnh khởi động Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
