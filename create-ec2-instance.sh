#!/bin/bash

# Set variables for EC2 instance configuration
AMI_ID="ami-082b1f4237bd816a1" # replace with desired AMI ID
INSTANCE_TYPE="t2.micro"
SECURITY_GROUP_ID="sg-017f5ac79caac7c6b" # replace with desired security group ID
SUBNET_ID="subnet-0bb79b484d5a54899" # replace with desired subnet ID
KEY_NAME="freqtrade" # replace with desired key pair name
# Create instance
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --subnet-id $SUBNET_ID --key-name $KEY_NAME --output text --query 'Instances[*].InstanceId')

# Wait for instance to be running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Sleep for 2 minutes
sleep 120

# Terminate instance
aws ec2 terminate-instances --instance-ids $INSTANCE_ID

echo "EC2 instance terminated with ID: $INSTANCE_ID"

