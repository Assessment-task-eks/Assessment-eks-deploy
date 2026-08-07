output "bank_api_repository_url" {

  value = aws_ecr_repository.bank_api.repository_url

}


output "upi_api_repository_url" {

  value = aws_ecr_repository.upi_api.repository_url

}
