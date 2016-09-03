FROM ubuntu:16.04
MAINTAINER Prussia <prussia.hu@gmail.com>

USER root

#================================================
# Customize sources for apt-get
#================================================
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

RUN apt-get update -qqy \
  && apt-get -qqy install build-essential wget unzip curl xvfb xz-utils zlib1g-dev libssl-dev

# 
#================================================
# Install Oracle JDK v8
#================================================
RUN \
  apt-get update 1>/dev/null && \
  apt-get install -y --no-install-recommends software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update 1>/dev/null && \
  apt-get install -y --no-install-recommends oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer



#============================
# Clean up
#============================
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.config/

WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


CMD ["bash"]