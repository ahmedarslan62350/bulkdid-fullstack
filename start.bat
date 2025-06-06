@echo off
title Full Project Starter
cls

:: === FRONTEND ===
echo =============================
echo === Frontend Environment ===
echo =============================
cd frontend
echo. > .env
echo Paste all frontend KEY=VALUE pairs below.
echo When done, press Ctrl+Z and Enter:
copy con fe_env.tmp
:: Wait for user to paste content
:: Ends on Ctrl+Z + Enter
:: (This is a built-in Windows feature)

:: Filter valid lines
findstr "=" fe_env.tmp > .env
del fe_env.tmp

:: === BACKEND ===
cd ..
echo =============================
echo === Backend Environment  ===
echo =============================
cd backend
echo. > .env.production
echo Paste all backend KEY=VALUE pairs below.
echo When done, press Ctrl+Z and Enter:
copy con be_env.tmp

:: Filter valid lines
findstr "=" be_env.tmp > .env.production
del be_env.tmp

:: === BUILD ===
cd ..
echo =============================
echo === Building Frontend... ===
echo =============================
cd frontend
call npm install
call npm run build

echo =============================
echo === Building Backend...  ===
echo =============================
cd ..\backend
call npm install
call build.bat

:: === START APPS ===
cd ..
echo =============================
echo === Starting All Apps... ===
echo =============================

cd frontend
start cmd /k "pm2 start npm --name frontend --start"

cd ..\backend
start cmd /k "npm start"

cd ..\whatsapp-message-sender
start cmd /k "npm start"

echo =============================
echo === All apps started!    ===
echo =============================
pause
