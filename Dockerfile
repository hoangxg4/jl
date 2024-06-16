# Sử dụng hình ảnh cơ sở Ubuntu
FROM ubuntu:latest

# Cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install jupyterlab

# Tạo một thư mục làm thư mục làm việc và thiết lập môi trường cho Jupyter
WORKDIR /workspace
ENV PATH="/root/.local/bin:${PATH}"

# Chạy Jupyter
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
