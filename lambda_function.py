import json
import os
import time
from datetime import datetime
import yfinance as yf
import requests


def lambda_handler(event, context):
    stocks_of_interest = json.loads(os.environ["ticker_symbols"])

    # Explicitly state the timezone so there is no confusion about the behavior
    #os.environ["TZ"] = "America/Vancouver"
    time.tzset()

    current_date = datetime.now()

    # Hypothetically if today is June 3, 2024, the date will be in this format '2024-06-03'
    formatted_date = current_date.strftime("%Y-%m-%d")

    result = {}

    for stock in stocks_of_interest:
        data = yf.download(stock, start=formatted_date, progress=False)
        if not data.empty:
            # iloc is integer location, there's too much unwanted text around it
            formatted_data = round(data["Open"].iloc[0], 2)
            # Force print output to always show 2 decimal places
            result[stock] = f"The open price for {stock} on {formatted_date} is ${formatted_data:0.2f} USD."
        else:
            result[stock] = f"No data available for {stock} on {formatted_date}"

    ntfy_string = ""
    for key, value in result.items():
        ntfy_string += value + "\n"
    ntfy_string += f"\nThe configured timezone is {os.environ['TZ']}."

    requests.post(os.environ["ntfy_server_topic"], data=ntfy_string.encode(encoding="utf-8"))

    return {
        "statusCode": 200,
        "body": json.dumps(result)
    }


# Run AWS Lambda locally for testing purposes
if __name__ == "__main__":
    event = []
    context = []
    lambda_handler(event, context)
