#!/bin/sh

export GOOGLE_CLOUD_KEYFILE_JSON=~/.config/gcloud/terraform-admin.json
export TF_VAR_credentials=$GOOGLE_CLOUD_KEYFILE_JSON
export TF_VAR_project_id=uob-tv-project-dev
