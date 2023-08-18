FROM linuxserver/ffmpeg

RUN apt-get update -y && apt-get install -y unzip fuse3

WORKDIR /app

COPY ./install_rclone.sh .
RUN bash ./install_rclone.sh

COPY assets/root/ /

COPY ./record_bytefm.sh .

ENTRYPOINT ["/bin/bash"]
CMD ["record_bytefm.sh", "00:59:55"]
