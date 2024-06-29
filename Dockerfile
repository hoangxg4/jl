FROM python:3.10  # Chọn phiên bản Python phù hợp

# Cài đặt JupyterLab và các thư viện cần thiết
RUN pip install jupyterlab

# Tạo token đăng nhập tùy chỉnh (11042006 trong trường hợp này)
RUN jupyter lab --generate-config
RUN echo "c.ServerApp.token = '11042006'" >> /root/.jupyter/jupyter_lab_config.py

# Mở cổng 8888 để truy cập JupyterLab từ bên ngoài
EXPOSE 8888

# Khởi động JupyterLab khi container chạy
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
