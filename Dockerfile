# Sử dụng image Python làm base
FROM python:3.9-slim-buster

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt Jupyter Notebook và các extensions phổ biến
RUN pip install --upgrade pip \
    && pip install jupyter notebook jupyterlab \
    && pip install ipywidgets

# Tạo thư mục làm việc
WORKDIR /workspace

# Cấu hình Jupyter Notebook
RUN mkdir /root/.jupyter \
    && echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.password = 'sha1:71096670f252:e4d19e9349249c89e746232251a6c603c8571f69e'" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py

# Port Jupyter Notebook sẽ sử dụng
EXPOSE 8888

# Khởi động Jupyter Notebook khi container chạy
CMD ["jupyter", "notebook", "--allow-root"]
