# Freqtrade Setup Script for Windows
Write-Host "Freqtrade Setup Script for Windows" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green

# Check if Python is installed
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python found: $pythonVersion" -ForegroundColor Yellow
} catch {
    Write-Host "Python not found! Please install Python 3.8 or higher." -ForegroundColor Red
    exit 1
}

# Create virtual environment
Write-Host "`nCreating virtual environment..." -ForegroundColor Yellow
python -m venv .venv

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& .\.venv\Scripts\Activate.ps1

# Upgrade pip
Write-Host "`nUpgrading pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Install TA-Lib
Write-Host "`nInstalling TA-Lib..." -ForegroundColor Yellow
Write-Host "Please download the appropriate TA-Lib wheel from:" -ForegroundColor Cyan
Write-Host "https://www.lfd.uci.edu/~gohlke/pythonlibs/#ta-lib" -ForegroundColor Cyan
Write-Host "Example: TA_Lib-0.4.26-cp39-cp39-win_amd64.whl for Python 3.9 64-bit" -ForegroundColor Gray
Write-Host "`nAfter downloading, install with: pip install <path-to-downloaded-file>" -ForegroundColor Gray
Write-Host "Press any key to continue after installing TA-Lib..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Install Freqtrade
Write-Host "`nInstalling Freqtrade and dependencies..." -ForegroundColor Yellow
pip install freqtrade

# Create necessary directories
Write-Host "`nCreating directory structure..." -ForegroundColor Yellow
if (!(Test-Path "user_data")) {
    New-Item -ItemType Directory -Path "user_data" | Out-Null
}
if (!(Test-Path "user_data\strategies")) {
    New-Item -ItemType Directory -Path "user_data\strategies" | Out-Null
}
if (!(Test-Path "user_data\data")) {
    New-Item -ItemType Directory -Path "user_data\data" | Out-Null
}
if (!(Test-Path "user_data\logs")) {
    New-Item -ItemType Directory -Path "user_data\logs" | Out-Null
}

Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Edit user_data\config.json with your exchange API keys" -ForegroundColor White
Write-Host "2. Download historical data:" -ForegroundColor White
Write-Host "   freqtrade download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframe 5m" -ForegroundColor Gray
Write-Host "3. Run backtesting:" -ForegroundColor White
Write-Host "   freqtrade backtesting --config user_data\config.json --strategy SampleStrategy" -ForegroundColor Gray
Write-Host "4. Start dry-run:" -ForegroundColor White
Write-Host "   freqtrade trade --config user_data\config.json --strategy SampleStrategy" -ForegroundColor Gray