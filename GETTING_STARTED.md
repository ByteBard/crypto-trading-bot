# Getting Started with Freqtrade

## Installation Options

### Option 1: Docker (Recommended for beginners)

1. Install Docker Desktop
2. Run the bot:
   ```bash
   docker-compose up -d
   ```

### Option 2: Python Installation

#### Windows:
```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup.ps1
```

#### Linux/Mac:
```bash
chmod +x setup.sh
./setup.sh
```

## Configuration

### 1. Exchange API Keys

Edit `user_data/config.json`:

```json
"exchange": {
    "name": "binance",
    "key": "your_api_key_here",
    "secret": "your_api_secret_here",
}
```

### 2. Trading Pairs

Modify the `pair_whitelist` in config.json:

```json
"pair_whitelist": [
    "BTC/USDT",
    "ETH/USDT",
    "BNB/USDT"
]
```

### 3. Risk Management

Adjust these settings in config.json:

```json
"max_open_trades": 3,
"stake_amount": "unlimited",
"tradable_balance_ratio": 0.99,
"stoploss": -0.10
```

## Basic Commands

### Download Historical Data
```bash
freqtrade download-data \
    --exchange binance \
    --pairs BTC/USDT ETH/USDT \
    --timeframe 5m 1h \
    --days 30
```

### Backtesting
```bash
# Basic backtest
freqtrade backtesting \
    --config user_data/config.json \
    --strategy SampleStrategy \
    --timeframe 5m

# Backtest with date range
freqtrade backtesting \
    --config user_data/config.json \
    --strategy SampleStrategy \
    --timeframe 5m \
    --timerange 20210101-20210201
```

### Strategy Optimization
```bash
freqtrade hyperopt \
    --config user_data/config.json \
    --strategy SampleStrategy \
    --hyperopt-loss SharpeHyperOptLoss \
    --spaces buy sell \
    --epochs 100
```

### Live Trading

#### Dry Run (Paper Trading)
```bash
freqtrade trade \
    --config user_data/config.json \
    --strategy SampleStrategy \
    --db-url sqlite:///tradesv3.dryrun.sqlite
```

#### Live Trading (Real Money)
```bash
# WARNING: This uses real money!
# Set "dry_run": false in config.json first
freqtrade trade \
    --config user_data/config.json \
    --strategy SampleStrategy
```

## Monitoring

### Web UI
Access the web interface at: http://localhost:8080
- Username: freqtrader
- Password: SuperSecurePassword

### Telegram Bot
1. Create a bot with @BotFather on Telegram
2. Get your chat ID with @userinfobot
3. Update config.json:
   ```json
   "telegram": {
       "enabled": true,
       "token": "your_bot_token",
       "chat_id": "your_chat_id"
   }
   ```

## Creating Your Own Strategy

1. Copy `user_data/strategies/SampleStrategy.py` to a new file
2. Rename the class and update the strategy logic
3. Key methods to implement:
   - `populate_indicators()`: Add technical indicators
   - `populate_entry_trend()`: Define buy signals
   - `populate_exit_trend()`: Define sell signals

Example minimal strategy:

```python
from freqtrade.strategy import IStrategy
from pandas import DataFrame
import talib.abstract as ta

class MyStrategy(IStrategy):
    INTERFACE_VERSION = 3
    
    timeframe = '5m'
    stoploss = -0.10
    
    def populate_indicators(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        dataframe['rsi'] = ta.RSI(dataframe, timeperiod=14)
        return dataframe
    
    def populate_entry_trend(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        dataframe.loc[
            (dataframe['rsi'] < 30),
            'enter_long'] = 1
        return dataframe
    
    def populate_exit_trend(self, dataframe: DataFrame, metadata: dict) -> DataFrame:
        dataframe.loc[
            (dataframe['rsi'] > 70),
            'exit_long'] = 1
        return dataframe
```

## Safety Tips

1. **Always start with dry-run mode** to test your strategy
2. **Use stop-loss** to limit potential losses
3. **Start with small amounts** when going live
4. **Monitor your bot regularly** especially in the beginning
5. **Keep your API keys secure** and use IP whitelisting
6. **Backtest thoroughly** before live trading
7. **Never invest more than you can afford to lose**

## Troubleshooting

### Common Issues

1. **TA-Lib installation failed**
   - Windows: Download pre-compiled wheel from https://www.lfd.uci.edu/~gohlke/pythonlibs/#ta-lib
   - Linux: `sudo apt-get install build-essential python3-dev`

2. **Exchange connection errors**
   - Check API keys are correct
   - Ensure IP is whitelisted on exchange
   - Check if exchange is in maintenance

3. **Not enough balance**
   - Check `tradable_balance_ratio` setting
   - Ensure you have balance in `stake_currency`

## Resources

- Official Documentation: https://www.freqtrade.io/
- Strategy Examples: https://github.com/freqtrade/freqtrade-strategies
- Discord Community: https://discord.gg/MA9v74M
- Reddit: https://www.reddit.com/r/freqtrade/