FROM python:3.10

# Cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y \
        sudo \
        vim \
        nano

# Cài đặt JupyterLab và các thư viện Python
RUN pip install jupyterlab numpy pandas matplotlib

# Tạo thư mục làm việc cho JupyterLab
RUN mkdir /home/jovyan/work

# Tạo token đăng nhập tùy chỉnh
RUN jupyter lab --generate-config
RUN echo "c.ServerApp.token = '11042006'" >> /home/jovyan/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.root_dir = '/home/jovyan/work'" >> /home/jovyan/.jupyter/jupyter_lab_config.py

# Thêm user jovyan vào nhóm sudo
RUN usermod -aG sudo jovyan

# Mở cổng 8888
EXPOSE 8888

# Chạy JupyterLab dưới user jovyan
USER jovyan
WORKDIR /home/jovyan/work
CMD ["jupyter", "lab", "--ip=0.0.0.0"]
