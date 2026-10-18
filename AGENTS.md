# Orientações para Codex e outros agentes

Este repositório prepara investigação **autorizada** por REA e posterior criação original de app de mobilidade. Nenhum resultado pode ser inventado.

1. Use o REA (MCP/CLI) para investigar somente um APK fornecido localmente, autorizado; registre hash, versão, hipóteses, evidências e limitações de acordo com `docs/PROTOCOL.md`.
2. **Nunca commit** APK, assets proprietários, código descompilado, chaves, credenciais, tokens, capturas com dados de terceiros. Guarde em `private/`, `reports/` ou `artifacts/` (ignorados).
3. Não execute bypass de autenticação/pagamentos, não chame APIs privadas, não realize scraping autenticado, não altere APK original nem use identidade visual de terceiros.
4. Só comece a implementação independente de protótipo após criar uma especificação observável e testes. Escreva o teste antes do comportamento; rode testes reais. Nenhuma afirmação de equivalência sem prova.
5. Core gratuito, open source e local. Codex é opção explícita com nuvem, não uma dependência do REA, do CI ou do protótipo. Não introduza serviços pagos sem autorização.
6. GitHub Actions "Android emulator smoke" prova apenas que o emulador inicia; **não** prova que o protótipo funciona.
7. Para alterações, branch dedicada, testes, documentação e PR. Não altere a main sem análise.
8. Antes de instalar programas, use as versões e caminhos documentados, analise as mudanças propostas pelo setup.

Comandos: `bash scripts/test-project.sh`; `bash scripts/check-env.sh`; `bash scripts/inspect-apk.sh /caminho/autorizado.apk`.

O alvo inicial é um app próprio de solicitação **simulada** de corridas, sem integração ao backend de terceiros.
