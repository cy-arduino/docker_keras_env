# create a keras running env

From ubuntu:18.04

LABEL maintainer="chihying.phone@gmail.com"
LABEL version="0.8"
LABEL description="create a keras running env"

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
	bzip2 \
	patch \
	wget && \
	rm -rf /var/lib/apt/lists/*

# Install Anaconda
ENV DL_PATH /root/download

RUN rm -rf $DL_PATH &&  mkdir -p $DL_PATH && cd /root/download && wget --quiet --no-check-certificate https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh 
RUN bash $DL_PATH/Anaconda3-5.1.0-Linux-x86_64.sh -b
RUN cd ~/ && rm -rf $DL_PATH

ENV PATH /root/anaconda3/bin:${PATH}

RUN pip install --upgrade pip

# install tensorflow
ARG TENSORFLOW_VER=1.11
#RUN ["/bin/bash", "-c", "pip install tensorflow==$TENSORFLOW_VER --force-reinstall"]
RUN pip install tensorflow==$TENSORFLOW_VER --force-reinstall

# install Keras
ARG KERAS_VER=2.2.4
#RUN ["/bin/bash", "-c", "pip install keras==$KERAS_VER --force-reinstall"]
RUN pip install keras==$KERAS_VER --force-reinstall

# patch & workaround
COPY workaround_convert_from_keras_to_tflite.patch /root
RUN patch -p0 < /root/workaround_convert_from_keras_to_tflite.patch
RUN cd ~/ && rm -rf /root/*.patch

# install onnxmltools to convert keras model to onnx format
RUN pip install onnxmltools

#install packages for pytorch
RUN pip install torch
RUN pip install torchvision
RUN pip install matplotlib

# run command
CMD ["/bin/bash", "-c", "/root/data/run.sh"]
