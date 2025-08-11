@echo off
echo Running backtest with SampleStrategy...

REM Run backtesting
docker run --rm -v "%CD%/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting --config user_data/config.json --strategy SampleStrategy --timeframe 5m

echo.
echo Backtest completed! 
echo Check user_data/backtest_results/ for detailed results
echo.

REM Show backtest results
echo Showing backtest summary...
docker run --rm -v "%CD%/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting-show

pause