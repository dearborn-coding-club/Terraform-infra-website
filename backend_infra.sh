#!/bin/sh
S3NAME="terraformstate-$(date | md5sum | head -c 8)"
aws s3api create-bucket --bucket $S3NAME --region us-east-1
aws s3api put-bucket-versioning --bucket $S3NAME --versioning-configuration Status=Enabled
aws dynamodb create-table --table-name terraform-state-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --region us-east-1 --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5


