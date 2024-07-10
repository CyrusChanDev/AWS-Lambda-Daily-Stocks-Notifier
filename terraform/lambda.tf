# AWS Lambda layers allows the use of 3rd party Python libraries (like yfinance)
resource "aws_lambda_layer_version" "yfinance_layer" {
  filename   = var.layer_filename
  layer_name = var.layer_name
  compatible_runtimes = [var.lambda_runtime]
}

# Make Terraform automatically zip the main Lambda file before deploying
data "archive_file" "lambda_function_zip" {
    type        = "zip"
    source_file = var.lambda_source_file
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
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  timeout          = 7

  environment {
    variables = {
      TZ = var.timezone
      ticker_symbols = jsonencode(var.ticker_symbols)
      ntfy_server_topic = var.ntfy_server_topic
    }
  }

  layers = [
    aws_lambda_layer_version.yfinance_layer.arn,
  ]
}