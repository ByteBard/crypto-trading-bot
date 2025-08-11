#!/bin/bash

echo "Freqtrade Setup Script"
echo "====================="

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

# Install TA-Lib dependencies based on OS
install_talib() {
    echo "Installing TA-Lib dependencies..."
    
    case $OS in
        linux)
            sudo apt-get update
            sudo apt-get install -y build-essential wget
            cd /tmp
            wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
            tar -xzf ta-lib-0.4.0-src.tar.gz
            cd ta-lib/
            ./configure --prefix=/usr
            make
            sudo make install
            cd -
            ;;
        macos)
            brew install ta-lib
            ;;
        windows)
            echo "For Windows, please download TA-Lib from:"
            echo "https://www.lfd.uci.edu/~gohlke/pythonlibs/#ta-lib"
            echo "Install the appropriate .whl file for your Python version"
            ;;
    esac
}

# Setup Python environment
setup_python() {
    echo "Setting up Python environment..."
    
    # Create virtual environment
    python3 -m venv .venv
    
    # Activate virtual environment
    if [[ "$OS" == "windows" ]]; then
        source .venv/Scripts/activate
    else
        source .venv/bin/activate
    fi
    
    # Upgrade pip
    pip install --upgrade pip
    
    # Install requirements
    pip install -r requirements.txt
}

# Initialize Freqtrade
init_freqtrade() {
    echo "Initializing Freqtrade..."
    
    # Create user directory if it doesn't exist
    if [ ! -d "user_data" ]; then
        freqtrade create-userdir --userdir user_data
    fi
    
    echo "Setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Edit user_data/config.json with your exchange API keys"
    echo "2. Download historical data: freqtrade download-data --exchange binance --pairs BTC/USDT ETH/USDT --timeframe 5m"
    echo "3. Run backtesting: freqtrade backtesting --config user_data/config.json --strategy SampleStrategy"
    echo "4. Start dry-run: freqtrade trade --config user_data/config.json --strategy SampleStrategy"
}

# Main execution
echo "OS detected: $OS"
install_talib
setup_python
init_freqtrade