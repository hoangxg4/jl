# Sử dụng hình ảnh cơ sở Python 3
FROM python:3-slim

# Cài đặt các gói cần thiết để cài đặt Docker nội bộ
RUN apt-get update && apt-get install -y 
    apt-transport-https 
    ca-certificates 
    curl 
    gnupg-agent 
    software-properties-common

# Thêm chứng chỉ GPG chính thức của Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Thêm khoản Docker vào APT sources
RUN add-apt-repository 
   "deb [arch=amd64] https://download.docker.com/linux/debian 
   $(lsb_release -cs) 
   stable"

# Cập nhật khoản APT và cài đặt Docker CE
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Mở cổng mặc định cho JupyterLab
EXPOSE 8888

# Chạy JupyterLab
CMD ["jupyter", "lab", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
