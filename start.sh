#!/bin/bash

clear

# === CLONE REPOSITORIES ===
echo "============================="
echo "=== Cloning Repositories  ==="
echo "============================="

# Clone frontend
if [ ! -d "frontend" ]; then
  git clone git@github.com:ahmedarslan62350/bulkdid.git frontend
else
  echo "Frontend directory already exists, skipping clone."
fi

# Clone backend
if [ ! -d "backend" ]; then
  git clone git@github.com:ahmedarslan62350/bulkdid-backend.git backend
else
  echo "Backend directory already exists, skipping clone."
fi

if [ ! -d "whatsapp-message-sender" ]; then
  git clone https://github.com/ahmedarslandev/whatsapp-message-sender.git whatsapp-message-sender
else
  echo "whatsapp-message-sender directory already exists, skipping clone."
fi

# === MAKE build.sh EXECUTABLE ===
echo "Making backend/build.sh executable..."
chmod +x backend/build.sh

# === FRONTEND ENV SETUP ===
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

# === BACKEND ENV SETUP ===
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
