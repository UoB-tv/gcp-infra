# Get started with Terraform

This is the terraform scripts for UoB-TV Infrastructure in GCP.

## New Setup

First get google cloud credentials by running the bash script in the terraform folder, do this once for a machine.

    ./init_service_account.sh

Setup the environment in shell, secrets should never be checked into source control. Do this each time for a new shell.

    ./env.sh

Initialize Terraform for the first time. 

    terraform init


Make changes and validate terraform scripts with

    terraform plan

If no errors, ppply changes:

    terraform apply