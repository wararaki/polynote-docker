FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk python3.7 python3-pip wget tar gzip && \
    rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /
COPY requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt && \
    rm requirements.txt

RUN wget http://ftp.jaist.ac.jp/pub/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz && \
    tar xvzf spark-2.4.4-bin-hadoop2.7.tgz && \
    mv spark-2.4.4-bin-hadoop2.7 /usr/local && \
    ln -s /usr/local/spark-2.4.4-bin-hadoop2.7 /usr/local/spark && \
    rm spark-2.4.4-bin-hadoop2.7.tgz
ENV SPARK_HOME=/usr/local/spark
ENV PATH=${PATH}:${SPARK_HOME}/bin
# ENV PYSPARK_PYTHON=/usr/bin/python3

RUN wget https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz && \
    tar -zxvpf polynote-dist.tar.gz && \
    mv polynote /usr/local/polynote && \
    rm polynote-dist.tar.gz

COPY config.yml /usr/local/polynote/config.yml
RUN mkdir /notebooks

WORKDIR /usr/local/polynote
CMD [ "./polynote" ]
