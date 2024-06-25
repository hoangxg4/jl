# Sử dụng hình ảnh cơ bản Python
FROM python:3.9-slim

# Cài đặt các công cụ cơ bản
RUN apt-get update && apt-get install -y sudo

# Tạo một người dùng mới không có quyền root
RUN useradd -ms /bin/bash jupyter && echo "jupyter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Tạo thư mục làm việc
WORKDIR /home/jupyter/workspace

# Chuyển quyền sở hữu thư mục cho người dùng không có quyền root
RUN chown -R jupyter:jupyter /home/jupyter

# Mặc định chạy với người dùng không có quyền root
USER jupyter

# Khởi chạy JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''"]
