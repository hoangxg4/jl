# Sử dụng hình ảnh cơ bản Python
FROM python:3.9-slim

# Cài đặt sudo
RUN apt-get update && apt-get install -y sudo

# Tạo người dùng mới không có quyền root
RUN useradd -ms /bin/bash jupyter

# Thêm người dùng mới vào nhóm sudo và cho phép sử dụng sudo mà không cần mật khẩu
RUN usermod -aG sudo jupyter && echo "jupyter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Cài đặt JupyterLab
RUN pip install jupyterlab

# Tạo thư mục làm việc và chuyển quyền sở hữu thư mục cho người dùng không có quyền root
WORKDIR /home/jupyter/workspace
RUN chown -R jupyter:jupyter /home/jupyter

# Đặt người dùng mặc định
USER jupyter

# Khởi chạy JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''"]
