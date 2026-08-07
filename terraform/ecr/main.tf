resource "aws_ecr_repository" "bank_api" {

  name = "bank-api"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

}


resource "aws_ecr_repository" "upi_api" {

  name = "upi-api"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

}
