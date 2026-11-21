#!/usr/bin/env bash
set -euo pipefail

NETWORK="lab-net"
JS_CONTAINER="lab-juice-shop"
JS_URL="http://127.0.0.1:3000"

echo "==> [1] Checking Docker engine version..."
engine=$(docker version --format '{{.Server.Version}}')
echo "Docker engine: $engine"
major=${engine%%.*}

if [[ "$major" -lt 28 ]]; then
  echo "FAIL: Docker < 28.0.0 may expose localhost-published ports to the L2 segment" >&2
  exit 1
fi

echo "==> [2] Checking lab-net membership..."
docker network inspect "$NETWORK" --format '{{range .Containers}}{{.Name}}{{"\n"}}{{end}}'
echo "    (visually confirm only lab-kali and lab-juice-shop are listed)"

echo "==> [3] Verifying Juice Shop loopback binding..."
docker port "$JS_CONTAINER" | grep "3000/tcp -> 127.0.0.1:3000" \
  || { echo "FAIL: Juice Shop is not bound to 127.0.0.1" >&2; exit 1; }

echo "==> [4] Verifying Kali -> Juice Shop connectivity..."
lab_code=$(docker compose exec -T kali \
  bash -c "curl -s -o /dev/null -w '%{http_code}' http://juice-shop:3000")

if [[ "$lab_code" != "200" ]]; then
  echo "FAIL: expected 200 from Kali, got '$lab_code'" >&2
  exit 1
fi

echo "==> [5] Verifying host loopback access..."
host_code=$(curl -s -o /dev/null -w '%{http_code}' "$JS_URL")

if [[ "$host_code" != "200" ]]; then
  echo "FAIL: expected 200 from host, got '$host_code'" >&2
  exit 1
fi

echo "==> [6] Verifying egress is BLOCKED (failure here is the desired result)..."

set +e
docker compose exec -T kali \
  bash -c "curl -s --connect-timeout 5 -o /dev/null -w '%{http_code}' https://example.com"
egress_rc=$?
set -e

if [[ $egress_rc -eq 0 ]]; then
  echo "FAIL: Kali unexpectedly reached the internet" >&2
  exit 1
fi

echo
echo "OK: isolation model verified."