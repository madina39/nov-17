# Create Key Pair
resource "aws_key_pair" "cloud_2021" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOaEZGT6M9C4scj7f5Uj/V2O60Z8560qv1K1igeMZhiFrX0QikrXrQsT45HTmeKmonI9wWn4op8lktaqKo7R8gEXsuAWGiW4ICjQCGc6AloRTvBUI4OUqMRx4AMUabl0Fs+QtfKKc5P2UEpCeJxNI0tTPpB7bJ/7jnROU4IGitg8rVAAWhepfXhmQeg5rDNecsFDDgNNK1tGuOT7SmyzVVHTAQ3aOMWKhh0S9fge2tvWlCHaWwOGWFf6Bwmzj4/tHrxl5g/uLjXDlUmz42JLipogehy+qf9c1iHM6JMG61WAA6BktxKe+iKIJwBjpQmODOkDuyRwlXP2j2kLG+d3g2hqF/hJYlv5AlOlHVyAWf6MTZHb9r8ZCyj7K92uw3bqFJioH9pEHumPJlxqii7YlvVrUkkz7q7ttHEMII1Y1c6RJfvn94tVNDHKpxr6j6lJ5ndqL9VaFNti378NT0fQbaOd1i1sSMuRs51gsd6jqt4VNyNPeEEHZcEZJiCWr9l9E= macbookpro@MacBooks-MacBook-Pro.local"  # Replace with your actual SSH public key path
}

# Create Elastic IP
resource "aws_instance" "cloud_2021" {
  key_name                    = aws_key_pair.cloud_2021.key_name
  instance_type               = var.instance_types[0] # Choose the first instance type by default
  ami                         = var.ami[0]
  associate_public_ip_address = true

  # Security Group
  vpc_security_group_ids = [aws_security_group.cloud_2021.id]
}

# Create Security Group
resource "aws_security_group" "cloud_2021" {
  name        = "cloud_2021"
  description = "Security Group for cloud_2021"

  dynamic "ingress" {
    for_each = [22, 80, 443]

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.1/32"]
    }
  }

  dynamic "egress" {
    for_each = [8000, 8080, 8888]

    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
