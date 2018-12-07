#!/bin/bash


PROJECT_ID=uob-tv-project-dev
VIDEO_PROC_SA=video-proc-sa

#gcloud iam service-accounts create video-proc-sa \
#  --display-name "Video Processing Service Account"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member serviceAccount:${VIDEO_PROC_SA}@${PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/storage.objectViewer


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member serviceAccount:${VIDEO_PROC_SA}@${PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/storage.objectCreator


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member serviceAccount:${VIDEO_PROC_SA}@${PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/pubsub.subscriber


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member serviceAccount:video-proc-sa@${PROJECT_ID}.iam.gserviceaccount.com \
  --role roles/pubsub.publisher
