#!/usr/bin/env bash
set -euo pipefail

# Bước 0: Tự xác định thư mục gốc của repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$REPO_ROOT"

echo "📂 Repo root: $REPO_ROOT"

# Bước 1: Chuẩn bị thư mục dữ liệu & file .env
mkdir -p zalo_data/cookies

if [ -f ./.env.example ] && [ ! -f ./.env ]; then
  echo "Tạo .env từ .env.example"
  cp .env.example .env
fi

echo "Copy .env vào zalo_data/.env"
cp -f ./.env ./zalo_data/.env

# Bước 2: Dừng & xóa container/volume cũ
echo "🛑 Dừng & xóa container/volume cũ"
docker compose down --volumes --remove-orphans

# Bước 3: Build & khởi container mới
echo "🏗️ Build & chạy lại với --build"
docker compose up -d --build

# Bước 4: Thông báo hoàn tất
echo "✅ Hoàn tất! Container đang chạy:"
docker ps --filter "name=zalo-server"
