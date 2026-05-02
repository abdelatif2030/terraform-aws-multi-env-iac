region       = "us-east-1"
environment  = "dev"
project_name = "multi-env-demo"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
enable_nat_gateway   = false

allowed_ssh_cidr = ["0.0.0.0/0"]

instance_count             = 1
instance_type              = "t3.micro"
root_volume_size           = 20
create_eip                 = true
enable_detailed_monitoring = false

# REPLACE WITH YOUR SSH PUBLIC KEY
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCUdoIKkyELe7ddQWultX0IK/L1acrQrP7+TPcdj89+T55MmU0WkKXCYf0IGf0RqTwUEggfNneMlaOC6Nt8xPWqNQxb+9tPrtJAzFqsJAomDN4l4Zz3QJWkLXOukPXE4Oyqfz2PP7MfrJDm4lVlewxUqVEUDT0nDOzJwBwTlmFqYWFLvjBcXD1sT/TDLwQBgkpUyjQuUsWJfOmfE5DXxIW5DZOsLfcPKAhl19JUa/0H+CBHrWaVKY7QaNcewo/cxoiILx0K5T5sy9GGfJJbiVsFpsNQkkEbXkgM+MLe2ZScszazvy4Hfvp8lUm0MC3DWXhmhLN3e3PwMUM0p4ZxEzd0bKxgc6GehCVinDIzSwVvwrM7hnxLbVIsBmI4+T12x7+9XPVFXBqCoskItXqVCxqDJAq/BZg0SWqtZsVrqYcCjtfSaov6Jg1b3AcG6VMS4UTvBbIKG/Y15y8AKQ6T5HaUZgZmiOGyyp97jK8CA1H+AO6wUZlku0bbCb6yRSn9tYScN+FUSeJ6KqmUnyuJKkFlNK8P8h6Rw/g9jpBaB2MNgcO2ZkB22VmujMbNnhkJQRSdaG8/dLA/6k/R5lbbOcBQARuLtZkq3gkN5qslF88od/Uett9m4sIkasG8jucmETdgqEP2b5bAhZ7Rd5XoCq3Szvyl/6y/l9xOKBuT82Udww== your-email@example.com"
