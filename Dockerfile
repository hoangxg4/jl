FROM jupyter/base-notebook

# Cài đặt các gói cần thiết
USER root
RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    nano

# Tạo người dùng mới
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_GID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN useradd -m -s /bin/bash -N -u ${NB_UID} ${NB_USER}

# Thiết lập mật khẩu (lưu ý thay đổi 'yourpassword' bằng mật khẩu mạnh)
RUN echo "${NB_USER}:yourpassword" | chpasswd

# Thêm người dùng vào nhóm sudo
RUN adduser ${NB_USER} sudo

# Thiết lập thư mục làm việc và quyền sở hữu
RUN mkdir ${HOME}/work && \
    chown -R ${NB_USER}:${NB_GID} ${HOME}

# Thiết lập Jupyter Notebook
USER ${NB_USER}
WORKDIR ${HOME}

# Cấu hình Jupyter Notebook (tùy chọn)
# Ví dụ: tạo config file, cài đặt extensions, ...

# Khởi động Jupyter Notebook khi chạy container
CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--port", "8888", "--allow-root"]
