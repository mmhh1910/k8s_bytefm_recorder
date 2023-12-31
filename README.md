# k8s_record-bfm

Recorder for the byte.fm radio stream meant to be run in k8s.

What it does and how it works:

* record_bfm_cronjobs.yaml defines a hourly cronjob that starts the record_bytefm.sh script at every full hour.
* The bash script record_bytefm.sh record one hour of the byte.fm stream to mp3 using ffmpeg.
* The script then uploads the mp3 file to OneDrive using rclone.

What is missing in this repo?

* k8s/record_bfm_secrets.yaml which defines the RCLONE_ONEDRIVE_TOKEN and RCLONE_ONEDRIVE_DRIVEID secrets written to the rclone.conf file by the bash script before the upload to OneDrive.
* The "imagePullSecrets" named "registry-secret"

Running this on an arm64 k8s cluster on Oracle Cloud Infrastructure my build command is:

    docker build --push --platform linux/arm64 -t eu-frankfurt-1.ocir.io/frs4lzee0jfi/record-bfm:latest .

k8s apply:

    k apply -f k8s/record_bfm_secrets.yaml
    k apply -f k8s/record_bfm_cronjobs.yaml
