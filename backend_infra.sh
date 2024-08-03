#!/bin/sh
if [ "$1" != "delete" ]
then
    S3NAME="terraformstate-webbase"
    TABLE_NAME=terraform-state-lock
    aws s3api create-bucket --bucket $S3NAME --region us-east-1
    aws s3api put-bucket-versioning --bucket $S3NAME --versioning-configuration Status=Enabled
    aws dynamodb create-table --table-name $TABLE_NAME --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --region us-east-1 --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
elif [ "$1" = "delete" ]
then
    aws s3 rb s3://$S3NAME --force
    aws dynamodb delete-table --table-name $TABLE_NAME  
fi
