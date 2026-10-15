@echo off
chcp 65001 >nul
echo ============================================================
echo   OpenList-Worker 一键更新部署
echo ============================================================
cd /d "%~dp0"

echo [1/3] 拉取最新代码...
git pull origin main || (echo git pull 失败，请检查网络 && pause & exit /b 1)

echo [2/3] 构建前端(含中文)+ Worker...
set FRONTEND_BUILD_FROM_SOURCE=1
call pnpm install
call pnpm run build || (echo 构建失败 && pause & exit /b 1)

echo [3/3] 部署到 Cloudflare...
call npx wrangler deploy || (echo 部署失败 && pause & exit /b 1)

echo.
echo ============================================================
echo   部署完成! 刷新 ol.709787.xyz 即可看到更新
echo ============================================================
pause
