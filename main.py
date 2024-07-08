from datetime import datetime
import yfinance as yf


#with open("stocks.config", "r") as file:
#    stocks_of_interest = [line.strip() for line in file]
stocks_of_interest = ["SPY", "AAPL", "GOOG", "AMZN"]        # Get it working with AWS Lambda first before pre-optimizing

current_date = datetime.now()

# Hypothetically if today is June 3, 2024, the date will be in this format '2024-06-03'
formatted_date = current_date.strftime("%Y-%m-%d")


# Get today's stock data
for stock in stocks_of_interest:
    data = yf.download(stock, formatted_date, progress=False)
    # iloc is integer location, there's too much unwanted text around it
    formatted_data = round(data["Open"].iloc[0], 2)
    # Force print output to always show 2 decimal places
    print(f"The open price for {stock} on {formatted_date} is ${formatted_data:0.2f} USD.")