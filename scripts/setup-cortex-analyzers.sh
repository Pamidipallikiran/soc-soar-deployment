#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/TheHive-Project/Cortex-Analyzers.git"
TARGET_DIR="./Cortex-Analyzers"

echo "[+] Setting up Cortex-Analyzers..."

if [ -d "$TARGET_DIR/.git" ]; then
    echo "[+] Cortex-Analyzers already exists."
    echo "[+] Updating existing repository..."
    git -C "$TARGET_DIR" pull --ff-only
else
    echo "[+] Cloning official Cortex-Analyzers repository..."
    git clone "$REPO_URL" "$TARGET_DIR"
fi

echo
echo "[+] Cortex-Analyzers setup completed."
echo "[+] Location: $TARGET_DIR"
