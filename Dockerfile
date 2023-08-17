FROM linuxserver/ffmpeg

WORKDIR /app

COPY . .

ENTRYPOINT ["/bin/bash"]
CMD ["record_bytefm.sh"]
