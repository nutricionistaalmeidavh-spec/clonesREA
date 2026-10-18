#!/usr/bin/env bash
set -euo pipefail

# Nunca envia o APK: somente leitura local pelo REA.
if [[ "$#" -ne 1 ]]; then
  echo 'Uso: bash scripts/inspect-apk.sh /caminho/arquivo-autorizado.apk' >&2
  exit 2
fi
apk="$1"
if [[ ! -f "$apk" || ! -r "$apk" || "$apk" != *.apk ]]; then
  echo 'Informe um APK local legível (.apk), obtido de forma autorizada.' >&2
  exit 2
fi
if [[ -z "${REA_JADX_MCP_JAR:-}" || ! -r "$REA_JADX_MCP_JAR" ]]; then
  echo 'REA_JADX_MCP_JAR deve apontar para o JAR oficial local.' >&2
  exit 2
fi
if ! command -v rea >/dev/null 2>&1; then
  echo 'REA CLI ausente. Instale: npm install -g rea-agents@4.1.0' >&2
  exit 2
fi
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out_dir="$root/reports"
mkdir -p "$out_dir"
chmod 700 "$out_dir"
output="$out_dir/android-package.json"
temporary="$(mktemp "$out_dir/.android-package.XXXXXX")"
trap 'rm -f "$temporary"' EXIT

# REA inspeciona estaticamente; não executa o aplicativo.
rea inspect-android-package "$apk" --json > "$temporary"
if [[ ! -s "$temporary" ]]; then
  echo 'REA não produziu uma resposta.' >&2
  exit 1
fi
chmod 600 "$temporary"
mv -f "$temporary" "$output"
printf 'Relatório local salvo em: %s\n' "$output"
printf 'SHA-256 do APK: '
sha256sum "$apk" | cut -d' ' -f1
echo 'Não publique o APK ou conteúdo descompilado no Git.'
