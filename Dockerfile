FROM centos:centos7
MAINTAINER Tim v0.1 January 2015, v0.3 March 2015, v0.45 September 2015, v0.46 October 2015, v0.47 Nov 2015
RUN date
COPY Dockerfile /var/log/
RUN yum -y install gcc git libtool autoconf autogen intltool python guile perl-Package-Constants libusb make gcc-c++ glibc.i686 vim
ADD gcc-arm-none-eabi-4_9-2015q2-20150609-linux.tar.bz2 /usr/local/
RUN yum -y remove libusb
RUN git clone git://git.libusb.org/libusb.git /usr/local/libusb/
WORKDIR /usr/local/libusb
RUN ./autogen.sh && ./configure && make && make install
ENV PKG_CONFIG_PATH $PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
WORKDIR /usr/local
RUN curl -o dfu-util-0.8.tar.gz http://dfu-util.sourceforge.net/releases/dfu-util-0.8.tar.gz && tar -vxzf dfu-util-0.8.tar.gz
WORKDIR /usr/local/dfu-util-0.8
RUN ./autogen.sh && ./configure && make && make install
RUN dfu-util -V
RUN git clone -b v0.12.7-release --depth=1 https://github.com/nodejs/node.git /usr/local/node
WORKDIR /usr/local/node
RUN git checkout v0.12.7-release
RUN ./configure && make && make install
RUN npm install -g particle-cli
RUN particle help
RUN mkdir /particle
RUN git clone -b "release/0.4.7" --depth=1 https://github.com/spark/firmware.git /particle/
ENV PATH $PATH $PATH:/usr/local/gcc-arm-none-eabi-4_9-2015q2/bin
WORKDIR /particle
RUN make
VOLUME /app
RUN date
CMD /bin/bash
