output "instance_ids" {
  description = "Instance IDs"
  value       = aws_instance.main[*].id
}

output "instance_public_ips" {
  description = "Public IPs"
  value       = aws_instance.main[*].public_ip
}

output "instance_private_ips" {
  description = "Private IPs"
  value       = aws_instance.main[*].private_ip
}

output "elastic_ips" {
  description = "Elastic IPs"
  value       = aws_eip.main[*].public_ip
}

output "key_name" {
  description = "Key pair name"
  value       = aws_key_pair.main.key_name
}
