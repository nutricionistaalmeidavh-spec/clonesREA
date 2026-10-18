#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

echo 'Checando sintaxe dos scripts Bash...'
for script in scripts/*.sh; do
  bash -n "$script"
done

echo 'Testando rejeição de argumento ausente...'
if bash scripts/inspect-apk.sh >/dev/null 2>&1; then
  echo '[FALHA] inspect-apk deveria rejeitar falta de argumentos' >&2
  exit 1
fi
echo 'Testando rejeição de arquivo inexistente...'
if bash scripts/inspect-apk.sh /tmp/clonesrea-arquivo-inexistente.apk >/dev/null 2>&1; then
  echo '[FALHA] inspect-apk deveria rejeitar APK inexistente' >&2
  exit 1
fi
echo 'Testando verificação de pré-requisitos incompletos...'
if env -u REA_JADX_MCP_JAR bash scripts/check-env.sh >/dev/null 2>&1; then
  echo '[FALHA] check-env deveria rejeitar JAR não configurado' >&2
  exit 1
fi
echo 'Conferindo ignores críticos...'
for rule in '*.apk' '*.jar' 'private/' 'reports/' 'artifacts/' '.env'; do
  if ! grep -Fxq "$rule" .gitignore; then
    echo "[FALHA] .gitignore não contém $rule" >&2
    exit 1
  fi
done

echo '[OK] Testes básicos passaram (não incluem REA com APK nem emulador).'
