//
//  SearchLocationViewModel.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

protocol SearchViewModel: ObservableObject {
    var searchLocationInput: String { get set }
    var locationsList: [(LocationModel, CityWeatherModel)] { get }
}

final class SearchLocationViewModel: SearchViewModel {
    @Published var searchLocationInput: String = "" {
        didSet {
            guard searchLocationInput.count >= 3 else { return }
            Task { await updateLocations(with: searchLocationInput) }
        }
    }
    @MainActor
    @Published var locationsList = [LocationModel: CityWeatherModel?]()
    
    private let service: WeatherInfoService
        
    init(service: WeatherInfoService) {
        self.service = service
    }
    
    private func updateLocations(with string: String) async {
        do {
            let locations = try await service.searchLocations(with: string)
        } catch {
            //TODO: Handle errors
            return
        }
    }
    
    func fetchWeather(with locationID: String) async -> CityWeatherModel {
        return try! await service.getWeather(with: locationID)
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
