//
//  RootViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

import Combine

protocol RootViewModelProtocol: ObservableObject {
  var state: RootState { get }

  func startApp() async
}
