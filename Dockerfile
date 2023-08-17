FROM ubuntu:latest as builder
WORKDIR /opt
COPY . /opt
RUN sed -i s:/archive.ubuntu.com:/mirrors.tuna.tsinghua.edu.cn/ubuntu:g /etc/apt/sources.list \
    && apt update \
    && apt install g++ make -y \
    && make

FROM ubuntu:latest
WORKDIR /
COPY --from=builder /opt/mkplanet /usr/bin/mkplanet
RUN chmod +x /usr/bin/mkplanet
CMD ["mkplanet"]

