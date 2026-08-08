resource "aws_ecr_repository" "bank_api" {
  name                 = var.bank_api_repository
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.bank_api_repository
  }
}


resource "aws_ecr_repository" "upi_api" {
  name                 = var.upi_api_repository
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.upi_api_repository
  }
}