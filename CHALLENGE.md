## Desafio Técnico iOS — App de Catálogo de Filmes

Você deverá desenvolver um aplicativo iOS chamado **MovieBrowser**, que permite ao usuário visualizar uma lista de filmes, pesquisar títulos e salvar favoritos.

O objetivo é avaliar sua capacidade de construir uma aplicação iOS bem estruturada, testável e alinhada com boas práticas do ecossistema Apple.

---

# Contexto

O app deve consumir uma API pública de filmes e exibir uma lista com informações básicas de cada item.

Você pode usar uma das opções abaixo:

* TMDB API
* OMDb API
* Um JSON mockado localmente, caso prefira evitar dependência de chave de API

---

# Requisitos obrigatórios

## 1. Tela inicial — Lista de filmes

A tela inicial deve exibir uma lista de filmes contendo:

* Poster
* Título
* Ano de lançamento
* Descrição curta ou sinopse
* Indicador visual se o filme está favoritado

A lista deve carregar os dados de forma assíncrona.

---

## 2. Busca

O usuário deve conseguir pesquisar filmes por título.

Requisitos:

* Campo de busca no topo da tela
* Busca com debounce
* Exibir estado de carregamento
* Exibir mensagem quando nenhum resultado for encontrado
* Tratar erros de rede

---

## 3. Tela de detalhes

Ao tocar em um filme, abrir uma tela de detalhes contendo:

* Poster em tamanho maior
* Título
* Ano
* Gênero
* Sinopse completa
* Nota média, se disponível
* Botão para favoritar ou remover dos favoritos

---

## 4. Favoritos

O usuário deve conseguir marcar e desmarcar filmes como favoritos.

Os favoritos devem persistir entre sessões do app usando uma das opções:

* `UserDefaults`
* `SwiftData`
* `CoreData`
* Arquivo local com `Codable`

---

## 5. Estados da interface

A aplicação deve tratar claramente os seguintes estados:

* Loading
* Success
* Empty
* Error
* Offline ou falha de conexão

---

# Requisitos técnicos

Você deve usar:

* Swift
* SwiftUI
* Async/Await
* MVVM ou outra arquitetura bem justificada
* Injeção de dependência
* Separação entre camada de UI, domínio e dados
* Testes unitários para a lógica principal

---

# Diferenciais

Não são obrigatórios, mas contam pontos extras:

* Cache de imagens
* Paginação
* Pull to refresh
* Suporte a modo escuro
* Testes de UI
* Modularização
* Uso de protocolos para abstrair serviços
* Tratamento de acessibilidade com `accessibilityLabel`
* Suporte a localização
* Snapshot tests
* CI com GitHub Actions

---

# O que será avaliado

A avaliação levará em conta:

* Clareza da arquitetura
* Organização das pastas
* Qualidade do código Swift
* Uso correto de `async/await`
* Testabilidade
* Tratamento de erros
* Experiência do usuário
* Responsividade da interface
* Boas práticas com SwiftUI
* Nomes de variáveis, funções e tipos
* Baixo acoplamento entre camadas
* Facilidade para manutenção futura

---

# Sugestão de estrutura

```text
MovieBrowser
├── App
├── Features
│   ├── MovieList
│   ├── MovieDetail
│   └── Favorites
├── Domain
│   ├── Models
│   ├── UseCases
│   └── Repositories
├── Data
│   ├── DTOs
│   ├── Services
│   ├── Mappers
│   └── Persistence
├── DesignSystem
├── Shared
└── Tests
```

---

# Exemplo de entidades esperadas

```swift
struct Movie: Identifiable, Equatable {
    let id: String
    let title: String
    let year: String
    let posterURL: URL?
    let overview: String
    let genre: String?
    let rating: Double?
    var isFavorite: Bool
}
```

---

# Exemplo de protocolo para serviço

```swift
protocol MovieServiceProtocol {
    func searchMovies(query: String) async throws -> [Movie]
    func fetchMovieDetails(id: String) async throws -> Movie
}
```

---

# Testes esperados

Você deve criar testes unitários para pelo menos:

* Busca de filmes com sucesso
* Busca retornando lista vazia
* Erro de rede
* Favoritar filme
* Remover filme dos favoritos
* Persistência de favoritos
* ViewModel atualizando corretamente os estados de tela

Exemplo:

```swift
final class MovieListViewModelTests: XCTestCase {
    func testSearchMoviesWhenServiceReturnsResultsShouldUpdateStateToSuccess() async {
        // Given
        // When
        // Then
    }
}
```

---

# Entrega

O projeto deve ser entregue em um repositório Git contendo:

* Código-fonte completo
* `README.md` explicando arquitetura e decisões técnicas
* Instruções para rodar o projeto
* Instruções para rodar os testes
* Prints ou GIFs do app funcionando
* Observações sobre melhorias futuras

---

# Prazo sugerido

De 2 a 4 dias.

---

# Critério de aprovação

Um bom resultado deve demonstrar que você sabe construir uma aplicação iOS real, com código limpo, separação de responsabilidades, testes e boa experiência de usuário.

Um excelente resultado deve mostrar cuidado com arquitetura, domínio, tratamento de estados, acessibilidade, performance e facilidade de manutenção.
