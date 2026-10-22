#!/usr/bin/env bash

set -euo pipefail

echo "Starting Colima..."
colima start --cpu 4 --memory 12 --disk 80 --vm-type vz --vz-rosetta --mount-type virtiofs

echo "Pulling Kali Linux..."
docker pull kalilinux/kali-rolling

echo "Pulling OWASP Juice Shop..."
docker pull bkimminich/juice-shop:v20.2.0

echo "Setup complete."