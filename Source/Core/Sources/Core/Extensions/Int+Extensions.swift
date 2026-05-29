//
//  Int+Extensions.swift
//  Core
//
//  Created by Tiago de Oliveira on 29/05/26.
//

public extension Int {
  /// Converte o valor inteiro, interpretado como uma quantidade de minutos,
  /// para uma string no formato `HH:mm`.
  ///
  /// O valor das horas é calculado dividindo o número por `60`, enquanto os
  /// minutos restantes são obtidos pelo resto da divisão por `60`.
  ///
  /// Exemplo:
  /// ```swift
  /// 125.toTimeString() // "02:05"
  /// ```
  ///
  /// - Returns: Uma string formatada com duas casas para horas e minutos.
  func toTimeString() -> String {
    String(format: "%02d:%02d", self / 60, self % 60)
  }
}
