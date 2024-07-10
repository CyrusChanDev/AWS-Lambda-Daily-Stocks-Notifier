# main.tf -----

region = "us-west-2"

# lambda.tf -----

layer_filename = "../python.zip"
layer_name = "yfinance_layer_terraform"
lambda_runtime = "python3.10"
lambda_source_file = "../lambda_function.py"
function_name = "my_lambda_function"
lambda_handler = "lambda_function.lambda_handler"
lambda_timeout = 7
timezone = "America/Vancouver"
ticker_symbols = ["SPY", "AAPL", "GOOG", "AMZN"]
ntfy_server_topic = "https://ntfy.sh/cyruschandev"

# iam.tf -----

role_name = "lambda_role"
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

# eventbridge.tf -----

event_rule_name = "invoke_lambda_on_a_schedule"
# Cron runs every 2 minutes for easier debugging during development
schedule_expression = "cron(*/2 * * * ? *)"
event_target_id = "my_lambda_target"