# create a keras running env
# image
# 	build image locally: 
#		docker build --build-arg xxx=xxx -t chihyinglin/keras_env:0.x -f Dockerfile .
#		docker build -t chihyinglin/keras_env:0.5 -f Dockerfile .
# 	push image:
#		commmit dockerfile to https://github.com/cy-arduino/docker_keras_env
# 	pull image:
#		docker pull chihyinglin/keras_env
# 	run image:
#		jupyter notebook:
#			docker run -p 0.0.0.0:xxxx:8888 -v /c/Users/cy/Desktop/ChihYing/docker/smart_chair/data:/root/data chihyinglin/keras_env:0.x /root/anaconda3/bin/jupyter notebook --ip=* --allow-root
#			docker run -p 0.0.0.0:38888:8888 -v /c/Users/cy/Desktop/ChihYing/docker/smart_chair/data:/root/data chihyinglin/keras_env:0.2 /root/anaconda3/bin/jupyter notebook --ip=* --allow-root
#		cmd line
#			docker run -v /c/Users/cy/Desktop/ChihYing/docker/smart_chair/data:/root/data chihyinglin/keras_env:0.x 
#			docker run -v /c/Users/cy/Desktop/ChihYing/docker/smart_chair/data:/root/data chihyinglin/keras_env:0.5

From ubuntu:18.04

LABEL maintainer="chihying.phone@gmail.com"
LABEL version="0.7"
LABEL description="create a keras running env"


# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      wget && \
    rm -rf /var/lib/apt/lists/*

# Install Anaconda
ENV DL_PATH /root/download

RUN rm -rf $DL_PATH &&  mkdir -p $DL_PATH && cd /root/download && wget --quiet --no-check-certificate https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh 
RUN bash $DL_PATH/Anaconda3-5.1.0-Linux-x86_64.sh -b
RUN cd ~/ && rm -rf $DL_PATH

ENV PATH /root/anaconda3/bin:${PATH}

# install tensorflow
ARG TENSORFLOW_VER=1.11
#RUN ["/bin/bash", "-c", "pip install tensorflow==$TENSORFLOW_VER --force-reinstall"]
RUN pip install tensorflow==$TENSORFLOW_VER --force-reinstall

# install Keras
ARG KERAS_VER=2.2.4
#RUN ["/bin/bash", "-c", "pip install keras==$KERAS_VER --force-reinstall"]
RUN pip install keras==$KERAS_VER --force-reinstall

# patch & workaround
#COPY 
RUN ls -al /

# run command
CMD ["/bin/bash", "-c", "/root/data/run.sh"]
