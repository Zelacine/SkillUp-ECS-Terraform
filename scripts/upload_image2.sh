#!/bin/bash

# AWS creds VARs
#aws_region=$(aws --profile skillup configure get region)
aws_region=$(aws --profile default configure get region)
aws_account_id=$(aws sts get-caller-identity --query Account --profile default | sed 's/\"//g')

# Repo AWS ECR
repo=$aws_account_id.dkr.ecr.$aws_region.amazonaws.com

# deploy app Docker image
docker build -t ${image_name}:${image_tag} --build-arg DOCKER_TAG=${image_tag} ./files/flask-app/

# add TAG to Docker imag
docker tag ${image_name}:${image_tag} ${ecr_repository}:${image_tag}

# Log into AWS ECR
aws --profile default ecr get-login-password  | docker login --username AWS --password-stdin $repo

# Upload app image to AWS ECR
docker push ${ecr_repository}:${image_tag}
