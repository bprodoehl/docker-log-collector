FROM phusion/baseimage
MAINTAINER Brian Prodoehl <bprodoehl@connectify.me>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get -y upgrade

# install default Ruby
RUN apt-get install -y curl build-essential ruby ruby-dev wget

# install RVM, Ruby, and Bundler
#RUN \curl -k -L https://get.rvm.io | bash -s stable
#RUN /bin/bash -l -c "rvm requirements"
#RUN /bin/bash -l -c "rvm install 2.0"
#RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN gem install fluentd --no-ri --no-rdoc

# install ElasticSearch plugin
RUN apt-get install -y libcurl4-openssl-dev
RUN gem install fluent-plugin-elasticsearch --no-ri --no-rdoc

RUN mkdir /etc/service/fluentd
ADD fluentd.sh /etc/service/fluentd/run

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.2/docker-gen-linux-amd64-0.3.2.tar.gz
RUN tar xvzf docker-gen-linux-amd64-0.3.2.tar.gz

RUN mkdir /etc/service/dockergen
ADD dockergen.sh /etc/service/dockergen/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
