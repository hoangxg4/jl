# Sử dụng image chính thức của Jupyter
FROM jupyter/base-notebook

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Thiết lập JupyterLab không yêu cầu mật khẩu và chạy dưới quyền root
RUN mkdir -p /root/.jupyter && \
    echo "c.NotebookApp.password = ''" > /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py

# Mở cổng 8888
EXPOSE 8888

# Chạy với quyền root
USER root

# Lệnh chạy JupyterLab khi container khởi động
CMD ["jupyter", "lab", "--allow-root"]
