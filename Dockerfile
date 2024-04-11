# Sử dụng image Ubuntu 20.04 làm cơ sở
FROM ubuntu:20.04

# Cài đặt các gói cần thiết để chạy Docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Thêm repository Docker và cài đặt Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Cài đặt Python và Jupyter Lab
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip
RUN pip3 install jupyterlab

# Sao chép file Jupyter Lab config vào container
COPY jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

# Đặt thư mục làm việc và sử dụng lệnh Jupyter Lab để khởi chạy
WORKDIR /app
CMD ["jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
