FROM centos:7

RUN yum update -y && \
    yum install -y initscripts curl tar gcc libc6-dev git \
                gcc-c++ openssl-devel g++ make automake autoconf \
                curl-devel zlib-devel httpd-devel apr-devel \
                apr-util-devel sqlite-devel wget yum-utils bzip2 bzip2-devel \
                fontconfig freetype freetype-devel fontconfig-devel libstdc++ \
                rpm-build patch readline readline-devel libtool bison lzma which && \
                yum clean all

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#RUN curl -sSL https://get.rvm.io | bash -s stable
RUN curl -sSl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
RUN source /etc/profile.d/rvm.sh
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.9"
RUN /bin/bash -l -c "rvm use 2.1.9 --default"

# install nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
RUN yum install -y nodejs --nogpgcheck

RUN curl https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz | tar xz -C /usr/local

ENV PATH /usr/local/go/bin:$PATH

RUN mkdir -p /go/src /go/bin && chmod -R 777 /go

ENV GOPATH /go
ENV PATH /go/bin:$PATH

ADD build.sh /tmp/
RUN chmod +x /tmp/build.sh 

WORKDIR /tmp/

CMD ["./build.sh"]
