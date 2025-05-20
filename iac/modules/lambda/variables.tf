variable "vpc_id" {
  description = "VPC ID for Lambda"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Lambda"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for Lambda"
  type        = list(string)
}

variable "lambda_s3_bucket" {
  description = "S3 bucket containing Lambda deployment package"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for Lambda deployment package"
  type        = string
} 