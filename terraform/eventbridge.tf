# Cron expression to specify how frequently the Lambda function should be invoked by AWS CloudWatch
resource "aws_cloudwatch_event_rule" "cron_rule" {
  name                = "invoke_lambda_on_a_schedule"
  description         = "Triggers Lambda function on a schedule using cron"
  schedule_expression = "cron(*/2 * * * ? *)" # Runs every 2 minutes for testing
}

# Select the Lambda function for AWS CloudWatch to call
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.cron_rule.name
  target_id = "my_lambda_target"
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
