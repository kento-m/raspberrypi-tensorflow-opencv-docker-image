From resin/rpi-raspbian:jessie

RUN apt-get update && apt-get upgrade \
    && apt-get install -y gcc make openssl git wget unzip \
    && apt-get install -y libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libssh-dev \
    && apt-get install -y python3-pip python3-dev python3-numpy python3-scipy python3-pandas python3-h5py \
    && apt-get install -y build-essential cmake libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

# For python
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv \
    && export PYENV_ROOT="/.pyenv" \
    && export PATH="$PYENV_ROOT/bin:$PATH" \
    && eval "$(pyenv init -)" \
    && pyenv install 3.4.7 \
    && pyenv global 3.4.7

# For TensorFlow
RUN sudo python3 -m pip install --upgrade https://github.com/samjabrahams/tensorflow-on-raspberry-pi/releases/download/v1.1.0/tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl \
    && git clone https://github.com/keras-team/keras.git /keras \
    && cd /keras \
    && sudo python3 setup.py install

# For OpenCV
RUN mkdir /opencv \
    && cd /opencv \
    && wget https://github.com/opencv/opencv/archive/3.4.0.zip \
    && unzip 3.4.0.zip \
    && mkdir opencv-3.4.0/build \
    && cd opencv-3.4.0/build \
    && cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_IPP=ON .. \
    && make -j7 \
    && make install
