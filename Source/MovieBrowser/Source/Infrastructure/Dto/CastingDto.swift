import Foundation

struct CastingDto: Decodable {
  let id: Int
  let cast, crew: [CastDto]
}
