//
//  WatchProviderAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchProviderAdapter {
  func adapt(dto: WatchProvidersDto) -> WatchProvidersModel {
    .init(id: dto.id,
          results: adaptResults(dto: dto.results))
  }

  private func adaptResults(dto: [String: WatchProviderResultDto]) -> [String: WatchProviderResultModel] {
    dto.compactMapValues { value in
      adaptWatchProviderResult(dto: value)
    }
  }

  private func adaptWatchProviderResult(dto: WatchProviderResultDto) -> WatchProviderResultModel {
    .init(
      link: dto.link,
      flatrate: dto.flatrate?.compactMap(adaptWatchProvider),
      rent: dto.rent?.compactMap(adaptWatchProvider),
      buy: dto.buy?.compactMap(adaptWatchProvider),
      free: dto.free?.compactMap(adaptWatchProvider),
      ads: dto.ads?.compactMap(adaptWatchProvider)
    )
  }

  private func adaptWatchProvider(dto: WatchProviderDto) -> WatchProviderModel {
    .init(
      logoPath: dto.logoPath,
      providerID: dto.providerID,
      providerName: dto.providerName,
      displayPriority: dto.displayPriority
    )
  }
}
