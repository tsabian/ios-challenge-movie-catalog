//
//  AppNavigationRouterProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 21/06/26.
//

protocol AppNavigationRouterProtocol {
  associatedtype Feature
  var path: [Feature] { get set }

  func navigation(to feature: Feature)
}
