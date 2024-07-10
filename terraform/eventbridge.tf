# Cron expression to specify how frequently the Lambda function should be invoked by AWS CloudWatch
resource "aws_cloudwatch_event_rule" "cron_rule" {
  name                = var.event_rule_name
  description         = "Triggers Lambda function on a schedule using cron"
  schedule_expression = var.schedule_expression
}

# Select the Lambda function for AWS CloudWatch to call
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.cron_rule.name
  target_id = var.event_target_id
  arn       = aws_lambda_function.lambda_function.arn
}

# Allow AWS CloudWatch to invoke the Lambda function
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_rule.arn
}
