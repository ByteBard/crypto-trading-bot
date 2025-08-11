# 🤖 Crypto Trading Bot with Freqtrade

> **⚠️ WARNING: This bot trades with real money. Always test thoroughly in dry-run mode first!**

A professional cryptocurrency quantitative trading bot built with the Freqtrade framework. Features automated trading strategies, backtesting capabilities, risk management, and comprehensive monitoring.

## 📊 Project Status

### ✅ Completed Features
- [x] **System Architecture Design** - Freqtrade framework selected
- [x] **Development Environment** - Complete project structure with Docker support  
- [x] **Freqtrade Installation** - Docker and Python installation methods
- [x] **Trading Strategy** - RSI-based SampleStrategy with technical indicators
- [x] **Data Management** - Historical data download capabilities  
- [x] **Repository Setup** - GitHub repository with proper .gitignore

### 🚧 In Progress
- [ ] **Configuration Setup** - Exchange API credentials and settings
- [ ] **Backtesting** - Historical data analysis and performance testing

### 📋 Todo List (High Priority)
- [ ] **Run Backtesting** - Test strategy performance on historical data
- [ ] **Parameter Optimization** - Hyperopt integration for strategy tuning
- [ ] **Dry-run Trading** - Paper trading implementation
- [ ] **Monitoring & Alerts** - Telegram bot notifications
- [ ] **Cloud Deployment** - 24/7 server deployment

### 📈 Current Progress: 7/12 tasks completed (58%)

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

## 📁 Project Structure

```
crypto-trading-bot/
├── 📄 README.md                    # This file with project status
├── 📄 GETTING_STARTED.md           # Detailed setup guide  
├── 📄 DATA_DOWNLOAD_GUIDE.md       # Historical data download guide
├── 🐳 docker-compose.yml           # Docker configuration
├── 📜 requirements.txt             # Python dependencies
├── 🖥️ setup.ps1 / setup.sh         # Automated setup scripts
├── 📊 download_data.bat/.sh        # Data download scripts
├── 🚀 run_backtest.bat/.sh         # Backtesting scripts
├── 🔒 .gitignore                   # Git ignore rules (excludes sensitive files)
└── user_data/
    ├── 🏗️ config_template.json     # Configuration template (safe)
    ├── 📈 strategies/
    │   └── SampleStrategy.py       # RSI-based trading strategy
    ├── 📊 data/                    # Historical market data (gitignored)
    ├── 📝 logs/                    # Trading logs (gitignored)
    └── 📓 notebooks/               # Analysis notebooks
```

### 🔐 Security Features
- **Sensitive files excluded**: API keys, trading logs, and data files are gitignored
- **Template configuration**: Safe placeholder config without real credentials
- **No secrets in repo**: All sensitive information stays local

## ⚙️ Configuration

### 1. Copy Configuration Template
```bash
cp user_data/config_template.json user_data/config.json
```

### 2. Edit Configuration
Update `user_data/config.json` with:
- **Exchange API keys** (get from your exchange)
- **Trading pairs** (BTC/USDT, ETH/USDT, etc.)
- **Stake amount** (how much to trade per position)
- **Risk management** (stop loss, max trades, etc.)

### 3. Key Settings
```json
{
    "dry_run": true,              // Start with paper trading!
    "stake_amount": "unlimited",   // Use percentage of balance
    "max_open_trades": 3,         // Limit concurrent positions
    "stoploss": -0.10            // 10% stop loss
}
```

## 📈 Trading Strategy

### Current Strategy: RSI-Based
- **Entry**: RSI crosses above 30 (oversold bounce)
- **Exit**: RSI crosses above 70 (overbought)
- **Guards**: TEMA trend filter, Bollinger Bands position
- **Risk**: 10% stop loss, max 3 positions

### Creating Custom Strategies
1. Copy `user_data/strategies/SampleStrategy.py`
2. Modify entry/exit logic in `populate_*_trend()` methods
3. Test with backtesting before live trading

## 🧪 Backtesting Workflow

### 1. Download Historical Data
```bash
# Windows
download_data.bat

# Linux/Mac  
./download_data.sh
```

### 2. Run Backtest
```bash
# Windows
run_backtest.bat

# Linux/Mac
./run_backtest.sh
```

### 3. Analyze Results
Results include:
- Total profit/loss
- Win rate and number of trades
- Maximum drawdown
- Sharpe ratio
- Detailed trade analysis

## 🚀 Quick Commands

### Using Docker (Recommended)
```bash
# Download data
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframe 5m --days 30

# Run backtest
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable backtesting --config user_data/config.json --strategy SampleStrategy

# Start dry-run trading
docker run --rm -v "$(pwd)/user_data:/freqtrade/user_data" freqtradeorg/freqtrade:stable trade --config user_data/config.json --strategy SampleStrategy
```

### Using Python Installation
```bash
# List available exchanges
freqtrade list-exchanges

# List strategies
freqtrade list-strategies

# Test configuration
freqtrade test-pairlist --config user_data/config.json

# Start trading (dry-run)
freqtrade trade --config user_data/config.json --strategy SampleStrategy
```

## 🔍 Monitoring & Analysis

### Web Interface
Access at: http://localhost:8080
- Username: `freqtrader`
- Password: `SuperSecurePassword` (change in config!)

### Telegram Notifications
1. Create bot with @BotFather
2. Get chat ID with @userinfobot  
3. Update config.json with token and chat ID

### Jupyter Analysis
Use `user_data/notebooks/` for:
- Strategy analysis
- Performance visualization
- Market data exploration

## ⚠️ Risk Management

### Safety Checklist
- [ ] Always start with `"dry_run": true`
- [ ] Test strategies thoroughly with backtesting
- [ ] Start with small amounts when going live
- [ ] Set appropriate stop losses
- [ ] Monitor regularly, especially initially
- [ ] Keep API keys secure (IP whitelist recommended)
- [ ] Never invest more than you can afford to lose

### Best Practices
1. **Backtest extensively** - Multiple market conditions
2. **Paper trade first** - Verify strategy works live
3. **Start small** - Gradually increase position sizes
4. **Diversify** - Don't put all capital in one strategy
5. **Monitor actively** - Markets can change quickly

## 📚 Resources & Support

### Documentation
- [Freqtrade Official Docs](https://www.freqtrade.io/)
- [Strategy Development Guide](https://www.freqtrade.io/en/latest/strategy-customization/)
- [GETTING_STARTED.md](GETTING_STARTED.md) - Detailed setup guide
- [DATA_DOWNLOAD_GUIDE.md](DATA_DOWNLOAD_GUIDE.md) - Data acquisition help

### Community
- [Freqtrade Discord](https://discord.gg/MA9v74M) - Active community support
- [GitHub Discussions](https://github.com/freqtrade/freqtrade/discussions) - Q&A and ideas
- [Reddit r/freqtrade](https://www.reddit.com/r/freqtrade/) - Community discussions

### Examples & Strategies
- [Community Strategies](https://github.com/freqtrade/freqtrade-strategies) - Open source strategies
- [Technical Analysis Library](https://github.com/twopirllc/pandas-ta) - TA indicators

## 🔄 Updates & Changelog

This project is actively maintained. Check the commit history for latest updates and features.

### Recent Updates
- ✅ Complete project structure with Docker support
- ✅ RSI-based sample strategy implementation  
- ✅ Automated data download and backtesting scripts
- ✅ Comprehensive documentation and security measures
- 🚧 Next: Parameter optimization and live trading setup

## ⚖️ Disclaimer

**This software is for educational and research purposes only. Cryptocurrency trading involves substantial risk of loss. The authors and contributors are not responsible for any financial losses incurred through the use of this software.**

**Always:**
- Use dry-run mode for testing
- Start with small amounts  
- Understand the risks involved
- Comply with your local regulations

---

🤖 *Generated with [Claude Code](https://claude.ai/code)*

**Star ⭐ this repository if you find it helpful!**