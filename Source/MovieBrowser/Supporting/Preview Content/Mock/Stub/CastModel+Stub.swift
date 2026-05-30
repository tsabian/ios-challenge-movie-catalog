extension CastCatalogModel {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeCasting()
      return CastAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}

extension [CastModel] {
  static func mock() -> Self {
    CastCatalogModel.mock().cast
  }
}
