# Windows 실행 버전 빌드 방법

Windows에서 실행 가능한 `.exe` 버전을 만들려면 **Windows PC**에서 아래 순서대로 진행하세요.

## 필요 환경

- **Windows 10/11** (64비트)
- **Flutter SDK** 설치 및 `PATH` 등록  
  - [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install/windows)
- **Visual Studio 2022** (워크로드: "C++를 사용한 데스크톱 개발")  
  - Flutter 설치 시 `flutter doctor`로 확인

## 방법 1: 배치 파일로 빌드 (권장)

1. 이 프로젝트 폴더를 Windows PC에 복사합니다.
2. **`build_windows.bat`** 을 더블클릭해 실행합니다.
3. 완료 후 **`release_windows`** 폴더가 생성됩니다.
4. **`release_windows\ac_estimate_app.exe`** 를 실행하면 됩니다.

## 방법 2: 명령어로 직접 빌드

```cmd
flutter pub get
flutter build windows --release
```

빌드 결과물 위치:

- `build\windows\x64\runner\Release\`
- 실행 파일: `ac_estimate_app.exe`
- 이 폴더 안의 **모든 파일**(exe, dll 등)을 함께 배포해야 합니다.

## 배포 시 주의사항

- **`release_windows`** (또는 `Release`) 폴더 **전체**를 ZIP으로 압축해 전달하세요.
- `ac_estimate_app.exe`만 복사하면 DLL 부재로 실행되지 않습니다.
- 다른 Windows PC에서는 해당 폴더를 풀고 `ac_estimate_app.exe`를 실행하면 됩니다.

## macOS/Linux에서 Windows 빌드

Flutter는 **Windows 빌드를 Windows 환경에서만** 지원합니다.  
Mac이나 Linux에서는 Windows 버전을 만들 수 없으므로, Windows PC나 가상 머신(VM), CI(예: GitHub Actions)에서 위 방법으로 빌드해야 합니다.
