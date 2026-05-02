data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.environment}-key"
  public_key = var.public_key

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-key"
    }
  )
}

resource "aws_instance" "main" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.main.key_name
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true

    tags = merge(
      var.common_tags,
      {
        Name = "${var.environment}-root-volume-${count.index + 1}"
      }
    )
  }

  user_data = var.user_data
  monitoring = var.enable_detailed_monitoring

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-instance-${count.index + 1}"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "main" {
  count    = var.create_eip ? var.instance_count : 0
  instance = aws_instance.main[count.index].id
  domain   = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-eip-${count.index + 1}"
    }
  )
}
