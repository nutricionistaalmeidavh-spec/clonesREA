# clonesREA — Laboratório REA + Codex

Experimento da Artisys de **engenharia reversa assistida por IA** para investigar funções observáveis em um APK Android autorizado e criar um **protótipo próprio** de aplicativo de mobilidade. **Nenhum APK foi analisado, e nenhum clone foi gerado até aqui.** O projeto contém somente infraestrutura e instruções de investigação.

## Arquitetura R$ 0

- **REA (Reverse Engineer Anything) + jadx-headless-mcp:** análise estática local, com Java 17+.
- **GitHub Actions:** executa o Android virtual e gera screenshot de teste do ambiente (não de aplicativo).
- **Codex CLI:** **opção explícita** do usuário, com processamento hospedado e limites da conta ChatGPT; não faz parte do core open source.
- Notebook i5 / 8 GB: pode atuar como terminal, sem Android físico, Ollama nem GPU. APKs grandes podem exigir computador Linux com mais RAM.
- Nada de serviços pagos obrigatórios ou Google Cloud.

## Preparar REA — Ubuntu 24.04 ou WSL2 Ubuntu

Android no REA foi validado em Linux e exige Node.js 22.19+, JDK 17+ e JAR `jadx-headless-mcp-0.7.1-all.jar` adquirido da origem oficial. **REA não instala esse JAR nem o emulador.** Confira o [guia oficial](https://github.com/morluto/rea/blob/main/docs/android-analysis.md) antes de obter o JAR; não baixe artefatos de mirrors desconhecidos.

```bash
npm install -g rea-agents@4.1.0
export REA_JADX_MCP_JAR="$HOME/tools/jadx-headless-mcp-0.7.1-all.jar"
bash scripts/check-env.sh
rea doctor
```

Opcional — integrar Codex e autenticar com a conta ChatGPT, sem chave de API:

```bash
npm install -g @openai/codex
codex login
rea setup      # selecione Codex, revise o plano e confirme
codex
```

Para investigar **somente um APK local autorizado**:

```bash
bash scripts/inspect-apk.sh /caminho/arquivo-autorizado.apk
```

A saída fica em `reports/android-package.json` (ignorado pelo Git). Para investigar classes e métodos, consulte [o protocolo](docs/PROTOCOL.md). **Não faça upload de APK de terceiros a este repositório público.**

## Testes e Android virtual

```bash
bash scripts/test-project.sh
```

- **Project checks:** executado nos pushes e PRs, valida scripts sem IA ou APK.
- **Android emulator smoke:** pelo GitHub em Actions → Android emulator smoke → Run workflow. Inicializa um Android virtual, confirma ADB e faz screenshot da tela inicial, disponível como artifact `android-emulator-screenshot`. **Não demonstra um clone.**
- Futuramente, `scripts/emulator-smoke.sh` aceita `APP_APK_PATH` e `APP_PACKAGE_ID` para instalar e abrir um **protótipo próprio**, sem APIs privadas.

## Limites e segurança

O REA inspeciona estaticamente o APK; não recupera serviços privados, pagamentos, arquitetura de backend nem funcionalidades operacionais completas do aplicativo. O nome Uber pode servir apenas como referência educativa. Não reutilize marca, interface identificadora, ativos protegidos, credenciais, código descompilado ou serviços proprietários. Separe evidências de hipóteses.

Consulte `AGENTS.md`, `docs/PROTOCOL.md` e `docs/NEXT_STEPS.md`.

Referências: [REA](https://github.com/morluto/rea) · [REA Android](https://github.com/morluto/rea/blob/main/docs/android-analysis.md) · [Android Emulator Runner](https://github.com/ReactiveCircus/android-emulator-runner).
