@echo off
chcp 65001 >nul
echo ========================================
echo  대운공조시스템 - 견적서 앱 Windows 빌드
echo ========================================
echo.

where flutter >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Flutter가 PATH에 없습니다. Flutter SDK를 설치하고 PATH에 추가하세요.
    pause
    exit /b 1
)

echo [1/3] 패키지 가져오는 중...
call flutter pub get
if %ERRORLEVEL% neq 0 (
    echo [오류] flutter pub get 실패
    pause
    exit /b 1
)

echo.
echo [2/3] Windows Release 빌드 중...
call flutter build windows --release
if %ERRORLEVEL% neq 0 (
    echo [오류] flutter build windows 실패
    pause
    exit /b 1
)

echo.
echo [3/3] 실행 파일 위치 복사 중...
if not exist "release_windows" mkdir release_windows
xcopy /E /I /Y "build\windows\x64\runner\Release\*" "release_windows\"
if %ERRORLEVEL% neq 0 (
    echo [오류] 복사 실패
    pause
    exit /b 1
)

echo.
echo ========================================
echo  빌드 완료.
echo  실행: release_windows\ac_estimate_app.exe
echo  배포: release_windows 폴더 전체를 ZIP으로 압축해 전달하세요.
echo ========================================
pause
