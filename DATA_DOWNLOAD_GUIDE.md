# Historical Data Download Guide

## Method 1: Using Docker (Recommended)

### Windows Command Prompt:
```cmd
cd crypto-trading-bot
download_data.bat
```

### PowerShell:
```powershell
cd crypto-trading-bot
docker run --rm -v "${PWD}/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframes 5m --days 7
```

### Linux/Mac:
```bash
cd crypto-trading-bot
chmod +x download_data.sh
./download_data.sh
```

## Method 2: Manual Docker Commands

### Download Multiple Pairs at Once:
```bash
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data \
  --exchange binance \
  --pairs BTC/USDT ETH/USDT BNB/USDT ADA/USDT DOT/USDT \
  --timeframes 5m 1h \
  --days 30
```

### Download Individual Pairs (if above fails):
```bash
# Bitcoin
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BTC/USDT --timeframes 5m --days 30

# Ethereum  
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs ETH/USDT --timeframes 5m --days 30

# Binance Coin
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BNB/USDT --timeframes 5m --days 30
```

## Method 3: Using Python Installation

If you have Freqtrade installed locally:

```bash
# Activate virtual environment first
source .venv/bin/activate  # Linux/Mac
# or
.venv\Scripts\activate     # Windows

# Download data
freqtrade download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframes 5m --days 30
```

## Available Exchanges

You can download data from these exchanges:
- binance (recommended for most pairs)
- okx
- bybit
- huobi
- kucoin
- coinbasepro

## Popular Trading Pairs

### Major Pairs:
- BTC/USDT
- ETH/USDT
- BNB/USDT
- ADA/USDT
- DOT/USDT
- MATIC/USDT
- LINK/USDT
- UNI/USDT

### Timeframes:
- 1m (not recommended for backtesting - too much data)
- 5m (recommended for short-term strategies)
- 15m
- 1h (recommended for medium-term strategies) 
- 4h
- 1d (recommended for long-term strategies)

## Troubleshooting

### Issue: "Connection timeout"
- Try downloading fewer pairs at once
- Use a stable internet connection
- Try a different exchange

### Issue: "Rate limit exceeded"
- Add delays between downloads
- Download pairs individually
- Use different exchange

### Issue: "No data available"
- Check if the trading pair exists on the exchange
- Try a different date range
- Some pairs may not have historical data

## Verifying Downloaded Data

Check if data was downloaded successfully:

```bash
# List downloaded data files
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable list-data

# Check data info
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable list-data --show-timerange
```

## Data Storage Location

Downloaded data is stored in:
```
user_data/data/
├── binance/
│   ├── BTC_USDT-5m.json
│   ├── ETH_USDT-5m.json
│   └── ...
```

Each file contains OHLCV data (Open, High, Low, Close, Volume) for the specified timeframe.

## Next Steps After Download

1. **Verify data downloaded**:
   ```bash
   ls user_data/data/binance/
   ```

2. **Run backtesting**:
   ```bash
   docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting --config user_data/config.json --strategy SampleStrategy
   ```

3. **Check results**:
   Results will be saved in `user_data/backtest_results/`