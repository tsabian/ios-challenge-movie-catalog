//
//  CastModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct CastModel: Identifiable, Hashable {
  let gender, id: Int
  let knownForDepartment: String?
  let name, originalName: String
  let popularity: Double
  let profilePath: String?
  let castID: Int?
  let character: String?
  let creditID: String
  let order: Int?
  let department: String?
  let job: String?
}
