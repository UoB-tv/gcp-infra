#!/bin/sh

TF_VAR_project_id=uob-tv-project-dev
TF_ADMIN=terraform-admin
TF_VAR_credentials=~/.config/gcloud/terraform-admin.json

gcloud iam service-accounts create terraform \
  --display-name "Terraform admin account"

gcloud iam service-accounts keys create ${TF_VAR_credentials} \
  --iam-account terraform@${TF_VAR_project_id}.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:terraform@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/editor

gcloud projects add-iam-policy-binding ${TF_VAR_project_id} \
  --member serviceAccount:terraform@${TF_VAR_project_id}.iam.gserviceaccount.com \
  --role roles/storage.admin
