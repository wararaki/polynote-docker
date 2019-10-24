FROM python:3.7

RUN apt-get update && \
    apt-get install -y default-jdk wget tar && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

WORKDIR /
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    rm requirements.txt

RUN wget https://github.com/polynote/polynote/releases/download/0.2.8/polynote-dist.tar.gz && \
    tar -zxvpf polynote-dist.tar.gz && \
    rm -rf polynote-dist.tar.gz

COPY docker-entrypoint.sh /polynote/docker-entrypoint.sh
COPY config.yml /polynote/config.yml

RUN mkdir /notebooks

WORKDIR /polynote
ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]
