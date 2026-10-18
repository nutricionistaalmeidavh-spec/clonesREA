# Protocolo de evidências

## Objetivo
Investigar o fluxo observável de pedir uma corrida em app de referência **obtido legalmente** e especificar uma aplicação própria. Sem recuperar ou imitar serviços privados.

## Antes da análise
- Anote a origem legítima, a autorização de análise, o hash SHA-256 e a versão do APK **fora do Git**.
- No Linux, configure Java 17+, `REA_JADX_MCP_JAR` com o `jadx-headless-mcp-0.7.1-all.jar` oficial e REA.
- Rode `bash scripts/inspect-apk.sh /caminho/arquivo.apk` e armazene o JSON em `reports/`.

## Comandos REA disponíveis
```bash
rea inspect-android-package /caminho/arquivo.apk
rea search-android-classes /caminho/arquivo.apk MainActivity
rea inspect-android-class /caminho/arquivo.apk exemplo.MainActivity
rea inspect-android-method /caminho/arquivo.apk exemplo.MainActivity onCreate
rea trace-android-references /caminho/arquivo.apk exemplo.MainActivity
```

## Modelo de registro
| ID | Pergunta | Evidência (local, não no Git) | Conclusão | Limitações |
|---|---|---|---|---|
| REA-001 | Como se inicia a solicitação? | A coletar | Não investigado | APK ainda não disponível |
| REA-002 | Onde destino e origem aparecem? | A coletar | Não investigado | Uma tela não revela backend |
| REA-003 | Como o preço é exibido? | A coletar | Não investigado | Lógica remota não recuperável |

## Condições para fazer a demonstração
- Não copiar código/ícones/textos proprietários; utilizar nome e identidade próprios.
- Definir comportamento observável: origem, destino, mapa, tarifa simulada, solicitação simulada e cancelamento.
- Diferenciar claramente: evidência verificada, inferência, hipótese e desconhecido.
- Teste de integração e screenshot do **nosso** app antes de dizer que algo funciona.
- Não confundir boot de Android virtual com teste funcional do clone.
- REA Android realiza análise estática. Não executa o APK nem suporta plenamente split APK/AAB, serviços remotos e runtime do alvo.
