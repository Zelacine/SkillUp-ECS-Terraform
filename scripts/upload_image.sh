#!/bin/bash

# Login to ECR
#aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin AIDAZ7KP55HIJ3UQEEVR7.dkr.ecr.eu-central-1.amazonaws.com

# Tag the local Docker image with ECR repository URI
#docker tag my-flask-app:latest AIDAZ7KP55HIJ3UQEEVR7.dkr.ecr.eu-central-1.amazonaws.com/my-flask-app-alpine-2v:latest

# Push the Docker image to ECR
#docker push AIDAZ7KP55HIJ3UQEEVR7.dkr.ecr.eu-central-1.amazonaws.com/my-flask-app-alpine-2v:latest




# Define variables
REGION="eu-central-1"
REPOSITORY_NAME="my-flask-app-alpine"
IMAGE_TAG="latest"
AWS_ACCOUNT_ID="685751790032"
LOCAL_IMAGE_NAME="my-flask-app-alpine-2v"


# Check if the repository exists
if aws ecr describe-repositories --repository-names "$REPOSITORY_NAME" >/dev/null 2>&1; then
    echo "ECR repository '$REPOSITORY_NAME' already exists."
else
    echo "Creating ECR repository '$REPOSITORY_NAME'..."
    aws ecr create-repository --repository-name "$REPOSITORY_NAME" --region "$REGION"
fi

# Get the login command
LOGIN_CMD=$(aws ecr get-login-password --region "$REGION")

# Check if the login command succeeded
if [ $? -eq 0 ]; then
    # Log in to ECR
    echo "Logging in to Amazon ECR..."
    eval "$LOGIN_CMD"
else
    echo "Failed to retrieve login command from AWS CLI. Please check your credentials and try again."
    exit 1
fi

# Tag the local Docker image with ECR repository URI
IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"
docker tag "$LOCAL_IMAGE_NAME:$IMAGE_TAG" "$IMAGE_URI"

# Push Docker image to ECR repository
echo "Pushing Docker image to ECR repository..."
docker push "$IMAGE_URI"

# Check if the push was successful
if [ $? -eq 0 ]; then
    echo "Docker image pushed to ECR repository successfully."
else
    echo "Failed to push Docker image to ECR repository."
    exit 1
fi


