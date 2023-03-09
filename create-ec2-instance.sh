#!/bin/bash

# Set variables for EC2 instance configuration
ami_id="ami-082b1f4237bd816a1"    # Amazon Linux 2 AMI ID (replace with your desired AMI ID)
instance_type="t2.micro"          # Instance type (replace with your desired instance type)
security_group_id="sg-017f5ac79caac7c6b"  # Security group ID (replace with your desired security group ID)
key_pair_name="freqtrade"        # Key pair name (replace with your desired key pair name)
region="ap-southeast-1"                # Region (replace with your desired region)

# Create EC2 instance
instance_id=$(aws ec2 run-instances --image-id $ami_id --instance-type $instance_type --security-group-ids $security_group_id --key-name $key_pair_name --region $region | jq -r '.Instances[].InstanceId')

echo "EC2 instance created with ID: $instance_id"

# Wait for EC2 instance to become available
aws ec2 wait instance-status-ok --instance-ids $instance_id --region $region

# Sleep for 2 minutes before terminating instance
echo "Waiting for 5 minutes before terminating EC2 instance..."
sleep 120

# Terminate EC2 instance
aws ec2 terminate-instances --instance-ids $instance_id --region $region

echo "EC2 instance terminated with ID: $instance_id"
