# Crypto Trading Bot with Freqtrade

This project implements a cryptocurrency trading bot using the Freqtrade framework.

## Quick Start

### 1. Using Docker (Recommended)

```bash
# Download the docker-compose file and start
docker-compose up -d

# Check logs
docker-compose logs -f

# Stop the bot
docker-compose down
```

### 2. Using Python Environment

```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
# On Windows:
.venv\Scripts\activate
# On Linux/Mac:
source .venv/bin/activate

# Install Freqtrade
pip install freqtrade

# Initialize user directory
freqtrade create-userdir --userdir user_data

# Create new configuration
freqtrade new-config --config user_data/config.json
```

## Project Structure

```
crypto-trading-bot/
├── user_data/
│   ├── config.json         # Main configuration
│   ├── strategies/         # Trading strategies
│   ├── data/              # Downloaded historical data
│   ├── logs/              # Trading logs
│   └── notebooks/         # Jupyter notebooks for analysis
├── docker-compose.yml     # Docker configuration
└── README.md             # This file
```

## Configuration

Edit `user_data/config.json` to:
- Set your exchange API keys
- Choose trading pairs
- Set stake amount
- Configure risk management

## Creating Strategies

Strategies are Python files in `user_data/strategies/`. See `SampleStrategy.py` for template.

## Backtesting

```bash
# Download historical data
freqtrade download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframe 5m --days 30

# Run backtest
freqtrade backtesting --config user_data/config.json --strategy MyStrategy --timeframe 5m
```

## Useful Commands

```bash
# List available exchanges
freqtrade list-exchanges

# List available strategies
freqtrade list-strategies

# Test configuration
freqtrade test-pairlist --config user_data/config.json

# Start trading (dry-run)
freqtrade trade --config user_data/config.json --strategy MyStrategy
```