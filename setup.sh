#!/bin/bash

set -e  # Exit on any error

echo "==> Checking prerequisites..."
command -v python3 >/dev/null 2>&1 || { echo >&2 "python3 not found. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "git not found. Aborting."; exit 1; }

# Check and create virtual environment
if [ -d "fprime-venv" ]; then
  echo "==> Virtual environment already exists. Skipping creation."
else
  echo "==> Creating fprime virtual environment..."
  python3 -m venv fprime-venv
fi

if [ ! -f "fprime-venv/bin/activate" ]; then
  echo "❌ Virtual environment activation script missing!"
  exit 1
fi

echo "==> Activating virtual environment..."
source fprime-venv/bin/activate

echo "==> Installing west version 1.4.0..."
pip install west==1.4.0

echo "==> Current Directory:"
pwd

echo "==> Fetching git submodules..."
git submodule update --recursive --init

# Verify directory before changing into it
if [ ! -d "lib/zephyr-workspace" ]; then
  echo "❌ Directory lib/zephyr-workspace does not exist!"
  exit 1
fi

cd lib/zephyr-workspace
echo "==> Entered Directory:"
pwd

echo "==> Updating Zephyr workspace..."
west update
west zephyr-export

cd ../../
echo "==> Returned to Directory:"
pwd

echo "==> Installing Python requirements (this includes fprime-util)..."
pip install -r requirements.txt

echo "==> Generating F´ build system..."
fprime-util generate

echo "==> Building F´ project..."
fprime-util build -j4

echo "✅ Setup complete."