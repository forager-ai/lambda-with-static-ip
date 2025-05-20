# Terraform AWS Lambda with Fixed EIP for Outbound Traffic

## Structure

- `main.tf`, `variables.tf`, `outputs.tf`: Root configuration, wires modules together.
- `modules/network`: Provisions VPC, subnets, NAT Gateway, EIP, and security group.
- `modules/lambda`: Provisions Lambda function and IAM role.


# Sample AWS Lambda with Postgres Query

This repository contains Terraform code to deploy an AWS Lambda function with a fixed Elastic IP for outbound traffic, and a sample Python Lambda application that queries a Postgres table.

## Sample Lambda Application

The sample app (`sample_lambda_app/app.py`) connects to a Postgres database, queries a table, and iterates through the data.

### Packaging and Uploading to S3

1. Install dependencies and package the app:
   ```sh
   cd sample_lambda_app
   pip install -r requirements.txt -t .
   zip -r ../sample_lambda_app.zip .
   ```
2. Upload `sample_lambda_app.zip` to your S3 bucket:
   ```sh
   aws s3 cp ../sample_lambda_app.zip s3://<your-bucket>/sample_lambda_app.zip
   ```
3. Set the following environment variables for your Lambda function (via Terraform or AWS Console):
   - `DB_HOST`: Postgres host
   - `DB_PORT`: Postgres port (default: 5432)
   - `DB_NAME`: Database name
   - `DB_USER`: Database user
   - `DB_PASSWORD`: Database password
   - `TABLE_NAME`: Table to query (default: `sample_table`)

## Terraform Usage

1. Set the `lambda_s3_bucket` and `lambda_s3_key` variables to point to your uploaded zip file.
2. Run:
   ```sh
   terraform init
   terraform apply -var="lambda_s3_bucket=<your-bucket>" -var="lambda_s3_key=sample_lambda_app.zip"
   ```
3. The Lambda function will use the NAT Gateway's Elastic IP for all outbound requests. Whitelist the output EIP in your external APIs. 