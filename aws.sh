#!/bin/bash
#
# define env vars for AWS Vagrantfile

#export AWS_AMI="ami-9dff96f8"
# NVIDIA AMI in N Virginia
export AWS_AMI="ami-e998ea83"

export AWS_REGION="us-east-1"

export AWS_KEY="YOURAWSKEY.........."
export AWS_SECRETKEY="YOURAWSSECRETKEY......."
export AWS_KEYPAIR="yourkeypairname"
export AWS_PEM="/path/to/your/yourkeypairname.pem"

export VAGRANT_DEFAULT_PROVIDER=aws
