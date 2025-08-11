#!/bin/bash

echo "Starting historical data download..."
echo "This may take several minutes, please wait..."

# Download BTC/USDT 5m data for 7 days
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BTC/USDT --timeframes 5m --days 7

# Download ETH/USDT 5m data for 7 days  
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs ETH/USDT --timeframes 5m --days 7

# Download BNB/USDT 5m data for 7 days
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BNB/USDT --timeframes 5m --days 7

echo "Data download completed!"
echo "Check user_data/data/ folder for downloaded files"