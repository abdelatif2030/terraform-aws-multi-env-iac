output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "web_sg_id" {
  description = "Web Security Group ID"
  value       = module.security_groups.web_sg_id
}

output "instance_ids" {
  description = "EC2 Instance IDs"
  value       = module.ec2.instance_ids
}

output "instance_public_ips" {
  description = "EC2 Public IPs"
  value       = module.ec2.instance_public_ips
}

output "elastic_ips" {
  description = "Elastic IPs"
  value       = module.ec2.elastic_ips
}

output "ssh_command" {
  description = "SSH command"
  value       = length(module.ec2.elastic_ips) > 0 ? "ssh -i $env:USERPROFILE\\.ssh\\terraform_key ec2-user@${module.ec2.elastic_ips[0]}" : "No EIP assigned"
}
