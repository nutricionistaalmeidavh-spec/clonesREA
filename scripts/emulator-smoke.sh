#!/usr/bin/env bash
set -euo pipefail

if ! command -v adb >/dev/null 2>&1; then
  echo 'ADB não encontrado no PATH.' >&2
  exit 1
fi
if [[ -n "${APP_APK_PATH:-}" && -z "${APP_PACKAGE_ID:-}" ]] || [[ -z "${APP_APK_PATH:-}" && -n "${APP_PACKAGE_ID:-}" ]]; then
  echo 'Para testar protótipo, informe APP_APK_PATH e APP_PACKAGE_ID juntos.' >&2
  exit 2
fi

adb wait-for-device
state="$(adb shell getprop sys.boot_completed | tr -d '\r\n')"
if [[ "$state" != "1" ]]; then
  echo "Android ainda não inicializado (sys.boot_completed=$state)" >&2
  exit 1
fi
echo '[OK] Android virtual inicializado'
adb devices

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$root/artifacts/android"

if [[ -n "${APP_APK_PATH:-}" ]]; then
  if [[ ! -f "$APP_APK_PATH" ]]; then
    echo "APK do protótipo próprio não encontrado: $APP_APK_PATH" >&2
    exit 2
  fi
  adb install -r "$APP_APK_PATH"
  echo "Iniciando protótipo: $APP_PACKAGE_ID"
  event_log="$(adb shell monkey -p "$APP_PACKAGE_ID" -c android.intent.category.LAUNCHER 1 2>&1)"
  printf '%s\n' "$event_log"
  if ! grep -q 'Events injected: 1' <<< "$event_log"; then
    echo 'Não foi possível iniciar a Activity do protótipo.' >&2
    exit 1
  fi
  sleep 3
  filename="prototype.png"
else
  echo 'Nenhum protótipo recebido: somente teste de ambiente Android.'
  filename="android-boot.png"
fi

adb exec-out screencap -p > "$root/artifacts/android/$filename"
if [[ ! -s "$root/artifacts/android/$filename" ]]; then
  echo 'Falha: screenshot vazio.' >&2
  exit 1
fi
printf '[OK] Captura em artifacts/android/%s\n' "$filename"
