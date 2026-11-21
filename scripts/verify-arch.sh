#!/usr/bin/env bash
set -euo pipefail

echo "==> Verifying ARM64-native operation..."

kali_image_arch=$(docker image inspect lab-kali --format '{{.Architecture}}')
js_image_arch=$(docker image inspect bkimminich/juice-shop:v20.3.0 --format '{{.Architecture}}')
kali_runtime_arch=$(docker compose exec -T kali uname -m)

echo "lab-kali image architecture: $kali_image_arch"
echo "juice-shop image architecture: $js_image_arch"
echo "kali runtime architecture (uname): $kali_runtime_arch"

fail=0

for value in "$kali_image_arch" "$js_image_arch" "$kali_runtime_arch"; do
  if [[ "$value" != "arm64" && "$value" != "aarch64" ]]; then
    echo "FAIL: expected arm64/aarch64, got '$value'" >&2
    fail=1
  fi
done

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "OK: all layers are ARM64-native."