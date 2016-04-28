Step 0 : FROM centos:centos7
Step 1 : MAINTAINER Tim v0.1 January 2015, v0.3 March 2015, v0.45 September 2015, v0.46 October 2015, v0.47 Nov 2015
Step 2 : RUN date
Step 3 : COPY Dockerfile /var/log/
Step 4 : RUN yum -y install gcc git libtool autoconf autogen intltool python guile perl-Package-Constants libusb make gcc-c++ glibc.i686 vim
Step 5 : ADD gcc-arm-none-eabi-4_9-2015q2-20150609-linux.tar.bz2 /usr/local/
Step 6 : RUN yum -y remove libusb
Step 7 : RUN git clone git://git.libusb.org/libusb.git /usr/local/libusb/
Step 8 : WORKDIR /usr/local/libusb
Step 9 : RUN ./autogen.sh && ./configure && make && make install
Step 10 : ENV PKG_CONFIG_PATH $PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
Step 11 : WORKDIR /usr/local
Step 12 : RUN curl -o dfu-util-0.8.tar.gz http://dfu-util.sourceforge.net/releases/dfu-util-0.8.tar.gz && tar -vxzf dfu-util-0.8.tar.gz
Step 13 : WORKDIR /usr/local/dfu-util-0.8
Step 14 : RUN ./autogen.sh && ./configure && make && make install
Step 15 : RUN dfu-util -V
Step 16 : RUN git clone -b v0.12.7-release --depth=1 https://github.com/nodejs/node.git /usr/local/node
Step 17 : WORKDIR /usr/local/node
Step 18 : RUN git checkout v0.12.7-release
Step 19 : RUN ./configure && make && make install
Step 20 : RUN npm install -g particle-cli
Step 21 : RUN particle help
Step 22 : RUN mkdir /particle
Step 23 : RUN git clone -b "release/0.4.7" --depth=1 https://github.com/spark/firmware.git /particle/
Step 24 : ENV PATH $PATH $PATH:/usr/local/gcc-arm-none-eabi-4_9-2015q2/bin
Step 25 : WORKDIR /particle
Step 26 : RUN make
Step 27 : VOLUME /app
Step 28 : RUN date
Step 29 : CMD /bin/bash
