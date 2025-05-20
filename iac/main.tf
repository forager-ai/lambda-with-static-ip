module "network" {
  source = "./modules/network"
}

module "lambda" {
  source = "./modules/lambda"
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  security_group_ids = [module.network.lambda_sg_id]
  lambda_s3_bucket   = var.lambda_s3_bucket
  lambda_s3_key      = var.lambda_s3_key
} 