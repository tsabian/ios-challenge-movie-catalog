# ios-challenge-movie-catalog

Você deverá desenvolver um aplicativo iOS chamado MovieBrowser, que permite ao usuário visualizar uma lista de filmes, pesquisar títulos e salvar favoritos.

## Abordagem de Configuração do Projeto

### XcodeGen

O projeto utiliza **XcodeGen** para geração automatizada do arquivo de projeto Xcode (`.xcodeproj`). Esta abordagem oferece os seguintes benefícios:

- **Declarativo**: O projeto é definido em um arquivo `project.yml` legível, evitando conflitos frequentes em arquivos `.pbxproj` binários.
- **Versionamento**: Como `project.yml` é um arquivo de texto, facilita o rastreamento de mudanças no controle de versão.
- **Automação**: Reduz erros manuais ao adicionar arquivos, targets e dependências.
- **Consistência**: Garante que todos os desenvolvedores trabalhem com a mesma configuração de projeto.

Para gerar o projeto, execute:
```bash
make generate
```

Se quiser executar o XcodeGen manualmente (sem Makefile), use:
```bash
xcodegen generate --project Source/
```

### SwiftLint e SwiftFormat

O projeto utiliza **SwiftLint** e **SwiftFormat** para garantir qualidade e padronização do código:

#### SwiftLint
- **Análise estática**: Identifica violações de estilo e boas práticas de Swift.
- **Configuração**: Regras definidas em `.swiftlint.yml` para manter consistência.
- **Integração em Build Phases**: Executado automaticamente durante o processo de build como uma fase de script, validando o código antes da compilação.
- **Comando**: `swiftlint lint` é executado em tempo de build para verificar violações.

#### SwiftFormat
- **Formatação automática**: Aplica automaticamente convenções de estilo ao código.
- **Integração em Build Phases**: Configurado como uma fase de script no build para aplicar formatação antes da compilação.
- **Comando**: `swiftformat .` é executado em tempo de build para formatar todos os arquivos Swift.
- **Decisão de design**: Garante que o código seja legível e siga um padrão único em todo o projeto.
- **Compatibilidade**: Funciona em conjunto com SwiftLint para uma experiência coesa.

## Comandos do Makefile

O projeto possui um `makefile` com comandos para automatizar tarefas comuns de configuração e desenvolvimento.

| Comando        | Descrição |
|----------------|-----------|
| `make install` | Instala as ferramentas necessárias via Homebrew: **SwiftLint**, **SwiftFormat** e **XcodeGen**. Requer o Homebrew instalado. |
| `make clean`   | Remove artefatos gerados no repositório: `Source/*.xcodeproj`, `DerivedData`, diretórios `build`, `.build` e `.swiftpm`. |
| `make setup`   | Executa `install` e `clean` em sequência, preparando o ambiente do zero. |
| `make generate`| Injeta `TMDB_SSL_PINNING_KEY`, `API_TOKEN` e `API_KEY` nos `.xcconfig` de Debug/Release e gera o `.xcodeproj` via `xcodegen generate --project Source/`. |
| `make open`    | Abre o projeto `MovieBrowser.xcodeproj` no Xcode. |
| `make start`   | Executa `setup`, `generate` e `open` em sequência — fluxo completo para iniciar o desenvolvimento. |
| `make reset`   | Executa `clean` e depois `start` para recriar totalmente o ambiente e abrir o projeto. |

### Uso rápido

Para configurar e abrir o projeto do zero:
```bash
make start
```

Para apenas regenerar o projeto Xcode:
```bash
make generate
```

Para resetar totalmente o ambiente e abrir o projeto novamente:
```bash
make reset
```

## ApiClient Layer

Este projeto implementa pinning de chave pública para conexões HTTPS usando URLSessionDelegate. Em vez de fixar o certificado inteiro, fixamos o hash SHA‑256 da SubjectPublicKeyInfo (SPKI) da chave pública do servidor.