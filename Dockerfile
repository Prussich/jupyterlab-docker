
FROM ubuntu:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND noninteractive

# Update the apt-get and installs curl
RUN apt-get update \
  && apt-get install -y curl

RUN apt-get upgrade -y
RUN apt-get install -y language-pack-ru
ENV LANGUAGE ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales

# Update node version on apt-get
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Installs node.js, python, pip and setup tools
RUN apt-get install -y \
    python3.6 \
    python3-pip \
    python3-setuptools \
    nodejs \
    build-essential \
    libzmq3-dev \
    mc \
    libsndfile1 \
    python-pil \
    libsm6 \
    libxext6 \
    libxrender-dev \
    ffmpeg \
    graphviz

# Upgrade pip
RUN pip3 install --upgrade pip

# Upgrade npm
RUN npm install npm@latest -g

# Install jupyter notebook
RUN pip3 install \
  jupyter \
  jupyterlab
  
  # Fix ipython kernel version
RUN ipython3 kernel install

# Install nodejs kernel
RUN npm config set user 0 \
 && npm config set unsafe-perm true \
 && npm install ijavascript -g

RUN ijsinstall --hide-undefined --install=global

RUN mkdir /projects
VOLUME /projects

ENTRYPOINT jupyter lab --no-browser --ip=* --port=9000 --allow-root --notebook-dir=/projects/notebooks --NotebookApp.token="xxx"

# Install jupyter notebook
RUN pip3 install \
  setuptools==41.0.0 \
  tensorflow-cpu==1.15 \
  keras==2.2.5 \
  librosa \
  matplotlib \
  opencv-python \
  pillow \
  pandas \
  ipympl \
  graphviz
