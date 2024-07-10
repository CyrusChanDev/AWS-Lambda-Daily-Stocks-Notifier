# main.tf -----

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

# lambda.tf -----

variable "layer_filename" {
  description = "The filename of the Lambda layer zip file"
  type        = string
}

variable "layer_name" {
  description = "The name of the Lambda layer"
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
}

variable "lambda_source_file" {
  description = "The source file for the Lambda function"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"
  type        = string
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function"
  type        = number
}

variable "timezone" {
  description = "The timezone for the Lambda function"
  type        = string
}

variable "ticker_symbols" {
  description = "The stock(s) where information should be gathered from"
  type        = list(string)
}

variable "ntfy_server_topic" {
  description = "The ntfy server topic where the notification should be sent"
  type        = string
}

# iam.tf -----

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the role"
  type        = string
}

# eventbridge.tf -----

variable "event_rule_name" {
  description = "The name of the CloudWatch Event rule"
  type        = string
}

variable "schedule_expression" {
  description = "The cron schedule expression for EventBridge"
  type        = string
}

variable "event_target_id" {
  description = "The ID of the EventBridge target"
  type        = string
}
