#!/bin/bash

echo "Running backtest with SampleStrategy..."

# Run backtesting
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting --config user_data/config.json --strategy SampleStrategy --timeframe 5m

echo ""
echo "Backtest completed!" 
echo "Check user_data/backtest_results/ for detailed results"
echo ""

# Show backtest results
echo "Showing backtest summary..."
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting-show