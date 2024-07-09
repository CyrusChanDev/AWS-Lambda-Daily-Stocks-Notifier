import json
import os
import time
import yfinance as yf
from datetime import datetime


def lambda_handler(event, context):
    stocks_of_interest = ["SPY", "AAPL", "GOOG", "AMZN"]

    os.environ["TZ"] = "America/Vancouver"
    time.tzset()

    current_date = datetime.now()
    formatted_date = current_date.strftime("%Y-%m-%d")

    result = {}

    for stock in stocks_of_interest:
        data = yf.download(stock, start=formatted_date, progress=False)
        if not data.empty:
            formatted_data = round(data["Open"].iloc[0], 2)
            result[stock] = f"The open price for {stock} on {formatted_date} is ${formatted_data:0.2f} USD."
        else:
            result[stock] = f"No data available for {stock} on {formatted_date}"

    return {
        "statusCode": 200,
        "body": json.dumps(result)
    }


# Run AWS Lambda locally for testing purposes
if __name__ == "__main__":
    event = []
    context = []
    print(lambda_handler(event, context))
