# Próximos passos do experimento

## P0 — infraestrutura
- [x] Repo público e instruções de segurança
- [x] Checks de scripts e workflow de Android virtual preparados
- [ ] Rodar workflow no GitHub e confirmar artifact de screenshot
- [ ] Obter e verificar um JAR oficial do jadx-headless-mcp (fora do Git)
- [ ] Executar REA doctor em Linux/WSL2 ou VM privada

## P1 — análise (não executada)
- [ ] Escolher APK de referência de uso autorizado
- [ ] Registrar origem, hash, versão e limites
- [ ] Executar o REA e investigar exclusivamente os fluxos definidos
- [ ] Documentar evidências e dúvidas sem incluir conteúdo proprietário nos commits

## P2 — protótipo (não executado)
- [ ] Criar especificação e testes primeiro
- [ ] Agente implementar app Android independente em `prototype/`
- [ ] Definir ID de pacote próprio e identidade original
- [ ] Implementar dados simulados ou serviços self-hosted
- [ ] Adaptar GitHub Actions para montar APK do protótipo e passar `APP_APK_PATH` e `APP_PACKAGE_ID` ao script de smoke
- [ ] Testar fluxos em Android virtual, capturar screenshots do próprio app

## Como testar um protótipo quando existir
Com emulador já inicializado e ADB no PATH:
```bash
APP_APK_PATH=prototype/app/build/outputs/apk/debug/app-debug.apk \
APP_PACKAGE_ID=dev.artisys.mobility \
bash scripts/emulator-smoke.sh
```

Apenas configurar `APP_APK_PATH` não compila o app. Enquanto o protótipo não existir, os testes checam somente a infraestrutura. Evite inserir APK original do Uber ou outro app em GitHub Actions público.
