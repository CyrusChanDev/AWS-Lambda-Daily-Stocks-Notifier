# main.tf -----

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

# lambda.tf -----

variable "layer_filename" {
  description = "The filename of the Lambda layer zip file"
  type        = string
  default     = "../python.zip"
}

variable "layer_name" {
  description = "The name of the Lambda layer"
  type        = string
  default     = "yfinance_layer_terraform"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.10"
}

variable "lambda_source_file" {
  description = "The source file for the Lambda function"
  type        = string
  default     = "../lambda_function.py"
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "my_lambda_function"
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function"
  type        = number
  default     = 7
}

variable "timezone" {
  description = "The timezone for the Lambda function"
  type        = string
  default     = "America/Vancouver"
}

# iam.tf -----

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "lambda_role"
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# eventbridge.tf -----

variable "event_rule_name" {
  description = "The name of the CloudWatch Event rule"
  type        = string
  default     = "invoke_lambda_on_a_schedule"
}

# Runs every 2 minutes for easier debugging
variable "schedule_expression" {
  description = "The cron schedule expression for EventBridge"
  type        = string
  default     = "cron(*/2 * * * ? *)"
}

variable "event_target_id" {
  description = "The ID of the EventBridge target"
  type        = string
  default     = "my_lambda_target"
}
