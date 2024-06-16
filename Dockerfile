# Sử dụng image chính thức của Jupyter
FROM jupyter/base-notebook

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Thiết lập JupyterLab không yêu cầu mật khẩu
RUN mkdir -p ~/.jupyter && \
    echo "c.NotebookApp.password = ''" > ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py

# Mở cổng 8888
EXPOSE 8888

# Lệnh chạy JupyterLab khi container khởi động
CMD ["jupyter", "lab", "--allow-root"]
