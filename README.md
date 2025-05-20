# Terraform AWS Lambda with Fixed EIP for Outbound Traffic

This repository provides Terraform code to deploy an AWS Lambda function with a fixed Elastic IP (EIP) for outbound traffic. It also includes a sample Python Lambda application that queries a Postgres table.

---

## Overview

- **Infrastructure as Code (Terraform):** Provisions VPC, subnets, NAT Gateway, EIP, security group, Lambda function, and IAM role.
- **Sample Lambda App:** Python app that connects to a Postgres database and queries a table.

---

## Prerequisites

- AWS CLI configured
- Terraform installed
- Python 3.x and pip

---

## Step 1: Prepare the Sample Lambda Application

1. **Install dependencies and package the app:**
   ```sh
   cd sample_lambda_app
   pip install -r requirements.txt -t .
   zip -r ../sample_lambda_app.zip .
   ```

2. **Create an S3 bucket** (if you don't have one):
   ```sh
   aws s3 mb s3://<your-bucket>
   ```

3. **Upload the packaged Lambda app to S3:**
   ```sh
   aws s3 cp ../sample_lambda_app.zip s3://<your-bucket>/sample_lambda_app.zip
   ```

---

## Step 2: Deploy Infrastructure with Terraform

1. **Initialize and apply Terraform:**
   ```sh
   cd iac
   terraform init
   terraform apply -var="lambda_s3_bucket=<your-bucket>" -var="lambda_s3_key=sample_lambda_app.zip"
   ```

2. **Note the output EIP** after Terraform completes. This is the fixed IP your Lambda will use for outbound requests. Whitelist this EIP in any external APIs as needed.

---

## Step 3: Configure Lambda Environment Variables

After deployment, set the following environment variables for your Lambda function (via AWS Console or Terraform):

- `DB_HOST`: Postgres host
- `DB_PORT`: Postgres port (default: 5432)
- `DB_NAME`: Database name
- `DB_USER`: Database user
- `DB_PASSWORD`: Database password
- `TABLE_NAME`: Table to query (default: `sample_table`)

---

## Repository Structure

- `iac/main.tf`, `iac/variables.tf`, `iac/outputs.tf`: Root Terraform configuration
- `iac/modules/network`: VPC, subnets, NAT Gateway, EIP, security group
- `iac/modules/lambda`: Lambda function and IAM role
- `sample_lambda_app`: Sample Python Lambda function

