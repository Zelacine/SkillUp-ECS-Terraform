#!/bin/bash
set -e

# Define variables
REGION="eu-central-1"
REPOSITORY_NAME="my-flask-app-alpine"
IMAGE_TAG="latest"
AWS_ACCOUNT_ID="685751790032"
LOCAL_IMAGE_NAME="my-flask-app-alpine-2v"

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the repository exists
if aws ecr describe-repositories --repository-names "$REPOSITORY_NAME" --region "$REGION" >/dev/null 2>&1; then
    echo "ECR repository '$REPOSITORY_NAME' already exists."
else
    echo "Creating ECR repository '$REPOSITORY_NAME'..."
    aws ecr create-repository --repository-name "$REPOSITORY_NAME" --region "$REGION"
fi

# Get the login password and log in to ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

# Tag the local Docker image with ECR repository URI
IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"
docker tag "$LOCAL_IMAGE_NAME:$IMAGE_TAG" "$IMAGE_URI"

# Push Docker image to ECR repository
echo "Pushing Docker image to ECR repository..."
docker push "$IMAGE_URI"

echo "Docker image pushed to ECR repository successfully."
