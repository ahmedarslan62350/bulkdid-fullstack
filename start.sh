#!/bin/bash

clear
echo "============================="
echo "=== Frontend Environment ==="
echo "============================="

cd frontend || exit 1
> .env

echo "Paste all frontend KEY=VALUE pairs below."
echo "When done, press Ctrl+D to save."

cat > fe_env.tmp
grep "=" fe_env.tmp > .env
rm fe_env.tmp

cd ../backend || exit 1

echo "============================="
echo "=== Backend Environment  ==="
echo "============================="

> .env.production
echo "Paste all backend KEY=VALUE pairs below."
echo "When done, press Ctrl+D to save."

cat > be_env.tmp
grep "=" be_env.tmp > .env.production
rm be_env.tmp

# === BUILD FRONTEND ===
echo "============================="
echo "=== Building Frontend... ==="
echo "============================="
cd ../frontend || exit 1
npm install
npm run build

# === BUILD BACKEND ===
echo "============================="
echo "=== Building Backend...  ==="
echo "============================="
cd ../backend || exit 1
npm install
./build.sh

# === START ALL APPS ===
echo "============================="
echo "=== Starting All Apps... ==="
echo "============================="

# Start frontend with pm2
cd ../frontend || exit 1
pm2 start npm --name "frontend" -- start

# Start backend
cd ../backend || exit 1
pm2 start npm --name "backend" -- start

# Start whatsapp-message-sender
cd ../whatsapp-message-sender || exit 1
pm2 start npm --name "whatsapp" -- start

echo "============================="
echo "=== All apps started!    ==="
echo "============================="
