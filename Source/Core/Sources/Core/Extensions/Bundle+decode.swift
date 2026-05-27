import Foundation

public enum DecodingError: Error, Equatable {
  case fileNotFound
  case decodingFailed(description: String)
}

public extension Bundle {
  /// Decodifica um recurso JSON do bundle para o tipo informado usando um JSONDecoder padrão.
  /// - Parameters:
  ///   - type: Tipo destino que implementa Decodable.
  ///   - file: Nome do arquivo (com extensão) dentro do bundle.
  /// - Throws: DecodingError.fileNotFound quando o arquivo não é encontrado, DecodingError.decodingFailed para falhas de decodificação ou leitura.
  /// - Returns: Instância decodificada do tipo T.
  func decode<T: Decodable>(_ file: String) throws -> T {
    try decode(file, using: JSONDecoder())
  }

  /// Variante com injeção de JSONDecoder para maior flexibilidade (ex.: estratégias de data/chaves).
  /// - Parameters:
  ///   - type: Tipo destino que implementa Decodable.
  ///   - file: Nome do arquivo (com extensão) dentro do bundle.
  ///   - decoder: Instância de JSONDecoder a ser utilizada.
  /// - Throws: DecodingError.fileNotFound quando o arquivo não é encontrado, DecodingError.decodingFailed para falhas de decodificação ou leitura.
  /// - Returns: Instância decodificada do tipo T.
  func decode<T: Decodable>(_ file: String, using decoder: JSONDecoder) throws -> T {
    guard let url = url(forResource: file, withExtension: nil) else {
      throw DecodingError.fileNotFound
    }

    let data: Data
    do {
      data = try Data(contentsOf: url)
      return try decoder.decode(T.self, from: data)
    } catch {
      throw DecodingError.decodingFailed(description: error.localizedDescription)
    }
  }
}
