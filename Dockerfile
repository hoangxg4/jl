# Sử dụng image base là Ubuntu 20.04
FROM ubuntu:20.04

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y python3 python3-pip

# Cài đặt Jupyter Lab
RUN pip3 install jupyterlab

# Tạo một user mới (ví dụ: myuser)
RUN useradd -m myuser

# Thiết lập môi trường cho Jupyter Lab
ENV JUPYTER_CONFIG_DIR=/home/myuser/.jupyter

# Thiết lập thư mục làm việc
WORKDIR /home/myuser

# Chạy Jupyter Lab khi khởi động container
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
