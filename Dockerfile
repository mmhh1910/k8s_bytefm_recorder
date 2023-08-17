FROM linuxserver/ffmpeg

WORKDIR /app

COPY ./record_bytefm.sh .

ENTRYPOINT ["/bin/bash"]
CMD ["record_bytefm.sh"]
