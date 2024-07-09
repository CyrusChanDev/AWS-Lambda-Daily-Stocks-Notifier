# AWS Lambda layers allows the use of 3rd party Python libraries (like yfinance)
resource "aws_lambda_layer_version" "yfinance_layer" {
  filename   = "../python.zip"
  layer_name = "yfinance_layer_terraform"
  compatible_runtimes = ["python3.10"]
}

# Make Terraform automatically zip the main Lambda file before deploying
data "archive_file" "lambda_function_zip" {
    type        = "zip"
    source_file = "../lambda_function.py"
    output_path = "../${path.module}/lambda_function.zip"
}

# Delete the automatically created Lambda zip when 'terraform destroy' command is run
resource "null_resource" "lambda_function_zip_cleanup" {
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ../${path.module}/lambda_function.zip"
  }
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
}