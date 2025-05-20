output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = [aws_subnet.private.id]
}

output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}

output "nat_eip" {
  value = aws_eip.nat.public_ip
} 