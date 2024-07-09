terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
  region = "us-west-2"
}

# The purpose of assuming a Lambda role is to grant clearly defined permissions to execute functions
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

# Attach IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# AWS Lambda layers allows the use of 3rd party Python libraries (like yfinance)
resource "aws_lambda_layer_version" "yfinance_layer" {
  filename   = "../python.zip"
  layer_name = "yfinance_layer_terraform"
  compatible_runtimes = ["python3.10"]
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "../lambda_function.zip"
  function_name    = "my_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.10"
  timeout          = 7

  environment {
    variables = {
      TZ = "America/Vancouver"
    }
  }

  layers = [
    aws_lambda_layer_version.yfinance_layer.arn,
  ]

  source_code_hash = filebase64sha256("../lambda_function.zip")
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
}
