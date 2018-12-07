#!/bin/bash


TF_VAR_project_id=uob-tv-project-dev
TF_ADMIN=video-proc-sa

gcloud iam service-accounts create terraform \
  --display-name "Video Processing Service Account"

gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:video-proc-sa@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/storage.objectViewer


gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:video-proc-sa@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/storage.objectCreator


gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:video-proc-sa@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/pubsub.subscriber


gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:video-proc-sa@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/pubsub.publisher
