#!/usr/bin/env bash
set -euo pipefail

missing=0
for cmd in node npm java rea; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf '[OK] %s: %s\n' "$cmd" "$(command -v "$cmd")"
  else
    printf '[FALTA] %s\n' "$cmd" >&2
    missing=1
  fi
done

if command -v node >/dev/null 2>&1; then
  if node -e 'const [a,b] = process.versions.node.split(".").map(Number); process.exit((a===22&&b>=19)||(a===24&&b>=11)||a>=26?0:1)' ; then
    printf '[OK] Node %s compatível\n' "$(node -v)"
  else
    echo '[FALTA] REA exige Node 22.19+, 24.11+ ou 26+' >&2
    missing=1
  fi
fi

if command -v java >/dev/null 2>&1; then
  version="$(java -version 2>&1 | head -n1 | sed -nE 's/.*version "([0-9]+).*/\1/p')"
  if [[ -n "$version" && "$version" -ge 17 ]]; then
    printf '[OK] Java %s\n' "$version"
  else
    echo '[FALTA] Java 17+ no PATH' >&2
    missing=1
  fi
fi

if [[ -n "${REA_JADX_MCP_JAR:-}" && -f "$REA_JADX_MCP_JAR" && -r "$REA_JADX_MCP_JAR" ]]; then
  printf '[OK] REA_JADX_MCP_JAR: %s\n' "$REA_JADX_MCP_JAR"
else
  echo '[FALTA] Defina REA_JADX_MCP_JAR para jadx-headless-mcp-0.7.1-all.jar oficial' >&2
  missing=1
fi

if command -v codex >/dev/null 2>&1; then
  echo '[OPCIONAL] Codex CLI disponível'
else
  echo '[OPCIONAL] Codex CLI não instalado: análise REA pode ser feita sem ele'
fi

if [[ "$missing" -ne 0 ]]; then
  echo 'Ambiente incompleto. Veja README.md.' >&2
  exit 1
fi
echo 'Ambiente mínimo de análise REA pronto; verifique a instalação com: rea doctor'
