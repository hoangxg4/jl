FROM python:3.10

# Cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y \
        sudo \
        vim \
        nano

# Tạo user jovyan và thư mục làm việc, đặt quyền sở hữu
RUN useradd -ms /bin/bash jovyan \
    && mkdir -p /home/jovyan/work \
    && chown -R jovyan:jovyan /home/jovyan/work

# Cài đặt JupyterLab và các thư viện Python (dưới user jovyan)
USER jovyan
RUN pip install --user jupyterlab numpy pandas matplotlib

# Tạo token đăng nhập tùy chỉnh
RUN jupyter lab --generate-config
RUN echo "c.ServerApp.token = '11042006'" >> /home/jovyan/.jupyter/jupyter_lab_config.py
RUN echo "c.ServerApp.root_dir = '/home/jovyan/work'" >> /home/jovyan/.jupyter/jupyter_lab_config.py

# Thêm user jovyan vào nhóm sudo
USER root
RUN usermod -aG sudo jovyan

# Mở cổng 8888
EXPOSE 8888

# Chạy JupyterLab dưới user jovyan
USER jovyan
WORKDIR /home/jovyan/work
CMD ["jupyter", "lab", "--ip=0.0.0.0"]
