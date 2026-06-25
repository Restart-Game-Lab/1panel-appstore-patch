#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="/opt/1panel/resource/apps/local"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: 1Panel apps directory not found: $TARGET_DIR"
    echo "Please ensure 1Panel is installed."
    exit 1
fi

echo "Installing 1Panel appstore patch apps..."
cp -rf "$SCRIPT_DIR/apps/"* "$TARGET_DIR/"
echo "Done! Apps installed to $TARGET_DIR"
echo "Please refresh 1Panel app store to see the new apps."
