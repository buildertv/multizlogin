#!/bin/bash

# Tạo thư mục zalo_data và cookies
mkdir -p zalo_data/cookies

# Tạo proxies.json nếu chưa tồn tại
if [ ! -f "./zalo_data/proxies.json" ]; then
    echo "[]" > ./zalo_data/proxies.json
    echo "Created empty proxies.json"
fi

# Xử lý .env
if [ -f "./.env.example" ]; then
    echo "Found .env.example, using it as template..."
    
    if [ ! -f "./.env" ]; then
        cp .env.example .env
        echo "Created .env from .env.example in root directory"
    else
        echo "Root .env file already exists"
    fi

    cp .env ./zalo_data/.env
    echo "Copied .env to zalo_data directory for Docker"
else
    echo "No .env.example found, creating default .env files..."

    if [ ! -f "./zalo_data/.env" ]; then
        cat > ./zalo_data/.env <<EOF
MESSAGE_WEBHOOK_URL=
GROUP_EVENT_WEBHOOK_URL=
REACTION_WEBHOOK_URL=
PORT=3000
EOF
        echo "Created default .env template in zalo_data directory"
    fi

    if [ ! -f "./.env" ]; then
        cp ./zalo_data/.env ./.env
        echo "Created .env file in root directory for local development"
    fi
fi

echo "✅ Setup completed. You can now run: docker compose up -d --build"
echo "🛠 Đừng quên cập nhật file .env với webhook thực tế!"
