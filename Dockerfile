FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget tar python3.7 python3-pip && \
    alias python=python3.7 && \
    alias pip=pip3 && \
    rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /
COPY requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt && \
    rm requirements.txt

RUN wget https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz && \
    tar -zxvpf polynote-dist.tar.gz && \
    rm -rf polynote-dist.tar.gz

COPY config.yml /polynote/config.yml
RUN mkdir /notebooks

WORKDIR /polynote
CMD [ "./polynote" ]
